import 'dart:async';

import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/models/search_response.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    _repository = PatientRepository(getIt());

    on<MissedPatientsFetched>(_onMissedPatientsFetched);
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<OpenSchedule>(_onOpenSchedule);
  }

  late PatientRepository _repository;

  FutureOr<void> _onMissedPatientsFetched(
    MissedPatientsFetched event,
    Emitter<SearchState> emit,
  ) async {
    final clinicId = getIt<LocalStorageService>().user.clinics.first.id;

    try {
      final visitorsResponse = await _repository.missedVisitors(clinicId);
      emit(
        state.copyWith(
          missedPatient: visitorsResponse.data.map((e) => e.patient).toList(),
          searchResult: visitorsResponse.data
              .map(
                (e) => SearchResult(
                  id: e.patientId,
                  name: e.patient.name,
                  mobile: e.patient.mobile,
                ),
              )
              .toList(),
        ),
      );
    } catch (_) {}
  }

  FutureOr<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) {
      emit(
        state.copyWith(
          status: SearchStatus.noSearch,
          searchResult: const [],
        ),
      );
      return _onMissedPatientsFetched(const MissedPatientsFetched(), emit);
    }

    try {
      final results = await _repository.patientSearch(searchTerm);
      emit(
        state.copyWith(
          status: SearchStatus.search,
          searchResult: results,
          searchTerm: searchTerm,
        ),
      );
    } catch (_) {}
  }

  FutureOr<Patient?> getPatientWithId(int id) async {
    try {
      final results = await _repository.getPatientWithId(id);
      return results.data;
    } catch (_) {
      return null;
    }
  }

  Future<void> schedulePatient(int patientId, DateTime dateTime) async {
    final clinicId = getIt<LocalStorageService>().user.clinics.first.id;
    try {
      await _repository.scheduleVisitor(
        patientId: patientId,
        clinicId: clinicId,
        date: dateTime.dateInput,
      );
    } catch (_) {}
  }

  FutureOr<void> _onOpenSchedule(
    OpenSchedule event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(isNotSchedule: event.schedule));
  }
}
