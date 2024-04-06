import 'dart:async';

import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/exceptions/network_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/visitor_response.dart';
import 'package:dento_support/features/patients/models/visitors_count_response.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_list_event.dart';
part 'patient_list_state.dart';

class PatientListBloc extends Bloc<PatientListEvent, PatientListState> {
  PatientListBloc() : super(const PatientListState()) {
    _repository = PatientRepository(getIt());

    on<PatientsFetched>(_onPatientsFetched);
    on<SelectDate>(_onDateSelect);
    on<UpdateVisitorCount>(_onVisitorCountFetched);
    on<PatientDeleted>(_onPatientDelete);
  }

  late PatientRepository _repository;

  FutureOr<void> _onPatientsFetched(
    PatientsFetched event,
    Emitter<PatientListState> emit,
  ) async {
    emit(state.copyWith(status: PatientListStatus.initial));
    try {
      final response = await _fetchVisitorList(DateTime.now(), emit);
      emit(
        state.copyWith(
          status: PatientListStatus.success,
          patients: response.data.rows,
          totalAmount: response.totalAmount,
          cashAmount: response.cashAmount,
          visited: response.visited,
          pendingVisitor: response.pendingVisitor,
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'No internet connection',
          status: PatientListStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  FutureOr<void> _onVisitorCountFetched(
    UpdateVisitorCount event,
    Emitter<PatientListState> emit,
  ) async {
    emit(state.copyWith(status: PatientListStatus.initial));

    final result = <DateTime>[];
    final today = DateTime.now();

    for (var i = -14; i <= 14; i++) {
      result.add(today.add(Duration(days: i)));
    }

    final clinic = getIt<LocalStorageService>().user.clinics.first;
    final clinicId = clinic.id;
    final dayOff = clinic.dayOff;

    final visitors = <VisitorCalendar>[];
    var featurePatientCounts = <PatientCount>[];
    var missPatientCounts = <PatientCount>[];

    try {
      final countResponse = await _repository.getVisitorsCount(clinicId);
      featurePatientCounts = countResponse.featurePatientCount;
      missPatientCounts = countResponse.missPatientCount;
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }

    for (final date in result) {
      int? badge;
      var feature = false;

      final featureCount = featurePatientCounts.firstWhere(
        (element) =>
            element.date.day == date.day && element.date.month == date.month,
        orElse: () => PatientCount(date: date, count: -1),
      );

      if (featureCount.count != -1) {
        feature = true;
        badge = featureCount.count;
      }

      final missCount = missPatientCounts.firstWhere(
        (element) =>
            element.date.day == date.day && element.date.month == date.month,
        orElse: () => PatientCount(date: date, count: -1),
      );

      if (missCount.count != -1) {
        feature = false;
        badge = missCount.count;
      }

      // if (date.isToday) {
      //   badge = null;
      // }

      var isDayOff =
          dayOff.contains(DateFormatUtils.fullWeekDay(date).toLowerCase());
      if (badge != null && badge > 0) {
        isDayOff = false;
      }

      visitors.add(
        VisitorCalendar(
          dateTime: date,
          dayOff: isDayOff,
          badge: badge,
          feature: feature,
        ),
      );
    }

    emit(state.copyWith(dates: visitors, status: PatientListStatus.success));
  }

  FutureOr<void> _onDateSelect(
    SelectDate event,
    Emitter<PatientListState> emit,
  ) async {
    emit(state.copyWith(status: PatientListStatus.initial));
    final visitors = state.dates
        .map(
          (element) => element.day == event.calendar.day
              ? event.calendar.copyWith(selected: true)
              : element.copyWith(selected: false),
        )
        .toList();
    emit(state.copyWith(dates: visitors));

    try {
      final response = await _fetchVisitorList(event.calendar.dateTime, emit);
      emit(
        state.copyWith(
          status: PatientListStatus.success,
          patients: response.data.rows,
          totalAmount: response.totalAmount,
          cashAmount: response.cashAmount,
          visited: response.visited,
          pendingVisitor: response.pendingVisitor,
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (e) {
      debugPrint('_onDateSelect $e');
      emit(
        state.copyWith(
          status: PatientListStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  Future<VisitorResponse> _fetchVisitorList(
    DateTime dateTime,
    Emitter<PatientListState> emit,
  ) async {
    final date = dateTime.dateInput;
    emit(state.copyWith(date: dateTime));
    final clinicId = getIt<LocalStorageService>().user.clinics.first.id;
    return _repository.getVisiterInfoByDate(clinicId, date);
  }

  Future<void> _onPatientDelete(
    PatientDeleted event,
    Emitter<PatientListState> emit,
  ) async {
    await _repository.deletePatient(event.id);
    emit(state.copyWith(status: PatientListStatus.delete));
  }
}

class VisitorCalendar extends Equatable {
  const VisitorCalendar({
    required this.dateTime,
    this.dayOff = false,
    this.badge,
    this.selected = false,
    this.feature = false,
  });

  final DateTime dateTime;
  final bool dayOff;
  final int? badge;
  final bool selected;
  final bool feature;

  String get weekDay => DateFormatUtils.weekDate(dateTime);
  String get day => dateTime.day.toString();

  @override
  List<Object?> get props => [dateTime, dayOff, badge, selected, feature];

  VisitorCalendar copyWith({
    DateTime? dateTime,
    bool? selected,
  }) {
    return VisitorCalendar(
      dateTime: dateTime ?? this.dateTime,
      selected: selected ?? this.selected,
      dayOff: dayOff,
      badge: badge,
      feature: feature,
    );
  }
}
