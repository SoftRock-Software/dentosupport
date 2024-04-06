part of 'add_patient_cubit.dart';

enum PatientStatus { initial, loading, success, failure, edited }

class AddPatientState extends Equatable {
  const AddPatientState({
    this.status = PatientStatus.initial,
    this.patient,
    this.errorMessage = '',
  });

  final PatientStatus status;
  final Patient? patient;
  final String errorMessage;

  AddPatientState copyWith({
    PatientStatus? status,
    Patient? patient,
    String? errorMessage,
  }) {
    return AddPatientState(
      status: status ?? this.status,
      patient: patient ?? this.patient,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, patient, errorMessage];
}
