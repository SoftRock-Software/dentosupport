import 'dart:async';

import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/features/patients/models/medical_history.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'medical_state.dart';

class MedicalCubit extends Cubit<MedicalState> {
  MedicalCubit({required PatientRepository patientRepository})
      : _repository = patientRepository,
        super(const MedicalState()) {
    _repository.medicalHistories.listen(_onHistories);
  }

  final PatientRepository _repository;
  var _isClose = false;

  Future<void> addMedicalHistory() async {
    emit(state.copyWith(status: MedicalStatus.loading));
    try {
      await _repository.addMedicalHistory(state.medicalTitle);
      emit(
        state.copyWith(
          status: MedicalStatus.success,
          errorMessage: 'Medical history added successfully',
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: MedicalStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MedicalStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  Future<void> removeMedicalHistory(int id) async {
    try {
      await _repository.removeMedicalHistory(id);
      emit(
        state.copyWith(
          status: MedicalStatus.success,
          errorMessage: 'Medical history deleted successfully',
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: MedicalStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MedicalStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  void onMedicalTitleChanged(String title) {
    emit(state.copyWith(status: MedicalStatus.initial, medicalTitle: title));
  }

  void _onHistories(List<MedicalHistory> event) {
    if (_isClose) return;

    emit(
      state.copyWith(
        status: MedicalStatus.initial,
        medicalHistories: List.from(event..sort((a, b) => b.selected ? 1 : -1)),
      ),
    );
  }

  @override
  Future<void> close() {
    _isClose = true;
    return super.close();
  }
}
