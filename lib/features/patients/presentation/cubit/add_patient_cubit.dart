import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit() : super(const AddPatientState()) {
    _repository = PatientRepository(getIt());
  }

  late PatientRepository _repository;

  Future<void> addPatient(AddPatientParams params) async {
    emit(state.copyWith(status: PatientStatus.loading));
    try {
      final patientResponse = await _repository.addPatient(params);

      emit(
        state.copyWith(
          status: PatientStatus.success,
          patient: patientResponse.data,
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientStatus.failure,
          errorMessage: exception.message,
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

  Future<void> editPatient(AddPatientParams params, String id) async {
    emit(state.copyWith(status: PatientStatus.loading));
    try {
      await _repository.editPatient(params, id);

      emit(
        state.copyWith(status: PatientStatus.edited),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: PatientStatus.failure,
          errorMessage: exception.message,
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
