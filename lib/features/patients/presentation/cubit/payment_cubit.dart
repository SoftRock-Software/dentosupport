import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/visitors_count_response.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    List<String> onProcessTeeth = const [],
    required this.patientId,
  }) : super(const PaymentState()) {
    _repository = PatientRepository(getIt());
    _makeMonthDates();
    emit(state.copyWith(onProcessTeeth: onProcessTeeth));
    if (state.onProcessTeeth.length == 1) {
      selectTeeth(state.onProcessTeeth.first);
    }
  }

  late PatientRepository _repository;
  final clinicId = getIt<LocalStorageService>().user.clinics.first.id;
  final int patientId;

  void changePaymentType(PaymentType type) {
    emit(state.copyWith(type: type));
  }

  void markComplete({bool? value}) {
    emit(state.copyWith(marked: value));
  }

  void selectTeeth(String number) {
    final teeths = [...state.selectedTeeth];
    if (teeths.contains(number)) {
      teeths.remove(number);
    } else {
      teeths.add(number);
    }

    emit(state.copyWith(selectedTeeth: teeths));
  }

  Future<void> _makeMonthDates() async {
    final result = <DateTime>[];
    final today = DateTime.now();

    for (var i = 0; i <= 14; i++) {
      result.add(today.add(Duration(days: i)));
    }

    final dayOff = getIt<LocalStorageService>().user.clinics.first.dayOff;

    final visitors = <VisitorCalendar>[];
    var featurePatientCounts = <PatientCount>[];

    try {
      final countResponse = await _repository.getVisitorsCount(clinicId);
      featurePatientCounts = countResponse.featurePatientCount;
    } on AppResponseException catch (_) {
      // handle error message
    } catch (_) {
      // handle error message
    }

    for (final date in result) {
      int? badge;
      final featureCount = featurePatientCounts.firstWhere(
        (element) =>
            element.date.day == date.day && element.date.month == date.month,
        orElse: () => PatientCount(date: date, count: -1),
      );

      if (featureCount.count != -1) {
        badge = featureCount.count;
      }

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
          feature: true,
        ),
      );
    }

    emit(state.copyWith(dates: visitors));
  }

  void onDateSelect(VisitorCalendar calendar) {
    final visitors = state.dates
        .map(
          (element) => element.day == calendar.day
              ? calendar.copyWith(selected: true)
              : element.copyWith(selected: false),
        )
        .toList();

    emit(state.copyWith(dates: visitors));
  }

  void onNotesChanged(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void onAmountChanged(String amount) {
    emit(state.copyWith(amount: amount.isEmpty ? 0 : double.parse(amount)));
  }

  Future<void> addPayment(VisitorCalendar? visitorDate) async {
    String? date;
    if (visitorDate != null) {
      date = DateFormat('yyyy-MM-dd').format(visitorDate.dateTime);
    } else {
      final calendar = state.dates.firstWhere(
        (element) => element.selected == true,
        orElse: () => VisitorCalendar(dateTime: DateTime.now(), badge: -1),
      );

      if (calendar.badge != -1 && state.marked == false) {
        date = DateFormat('yyyy-MM-dd').format(calendar.dateTime);
      }
    }

    debugPrint('Selected date $date');

    final processedToothNumber = <String>[];

    for (final tooth in state.selectedTeeth) {
      if (tooth == 'Upper') {
        final upper = [
          '11',
          '12',
          '13',
          '14',
          '15',
          '16',
          '17',
          '18',
          '21',
          '22',
          '23',
          '24',
          '25',
          '26',
          '27',
          '28'
        ];

        processedToothNumber.addAll(upper);
      } else if (tooth == 'Lower') {
        final lower = [
          '31',
          '32',
          '33',
          '34',
          '35',
          '36',
          '37',
          '38',
          '41',
          '42',
          '43',
          '44',
          '45',
          '46',
          '47',
          '48'
        ];

        processedToothNumber.addAll(lower);
      } else {
        processedToothNumber.add(tooth);
      }
    }

    final params = AddTransactionParams(
      notes: state.notes,
      processedToothNumber: processedToothNumber.join(','),
      amount: state.amount,
      type: state.type.value,
      date: date,
      clinicId: clinicId,
      patientId: patientId,
      isCompleted: state.marked,
    );

    debugPrint(params.toJson().toString());

    try {
      await _repository.addTransaction(params);

      emit(
        state.copyWith(
          status: PaymentStatus.success,
          errorMessage: 'Add Payment successfully',
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }
}

enum PaymentType { online, cash }

extension GenderExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.online:
        return 'Online';
      case PaymentType.cash:
        return 'Cash';
    }
  }
}
