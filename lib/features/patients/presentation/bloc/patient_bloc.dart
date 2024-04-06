import 'dart:async';

import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/exceptions/network_exception.dart';
import 'package:dento_support/core/extensions/list_extension.dart';
import 'package:dento_support/features/patients/models/next_schedule.dart';
import 'package:dento_support/features/patients/models/transaction.dart';
import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc({required PatientRepository patientRepository})
      : _repository = patientRepository,
        super(const PatientState()) {
    on<FetchPatient>(_onFetchedPatient);
  }

  final PatientRepository _repository;

  FutureOr<void> _onFetchedPatient(
    FetchPatient event,
    Emitter<PatientState> emit,
  ) async {
    emit(state.copyWith(status: PatientStatus.initial));

    try {
      final patientResponse = await _repository.getPatientWithId(event.id);

      emit(
        state.copyWith(
          status: PatientStatus.success,
          transactions: patientResponse.data.transactions,
          treatmets: patientResponse.data.treatments,
          receivedPayment: patientResponse.receivedPayment,
          totalPayment: patientResponse.totalPayment,
          pendingPayment: patientResponse.pendingPayment,
          onProcessTeeth:
              patientResponse.onProcessTeeth.sorted((a, b) => a.compareTo(b)),
          nextSchedule: patientResponse.nextSchedule,
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'No internet connection',
          status: PatientStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: PatientStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }
}
