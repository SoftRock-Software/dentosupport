part of 'medical_cubit.dart';

enum MedicalStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == MedicalStatus.initial;
  bool get isLoading => this == MedicalStatus.loading;
  bool get isSuccess => this == MedicalStatus.success;
  bool get hasError => this == MedicalStatus.failure;
}

class MedicalState extends Equatable {
  const MedicalState({
    this.status = MedicalStatus.initial,
    this.medicalTitle = '',
    this.medicalHistories = const [],
    this.errorMessage = '',
  });

  final MedicalStatus status;
  final String medicalTitle;
  final List<MedicalHistory> medicalHistories;

  final String errorMessage;

  MedicalState copyWith({
    MedicalStatus? status,
    String? medicalTitle,
    List<MedicalHistory>? medicalHistories,
    String? errorMessage,
  }) {
    return MedicalState(
      status: status ?? this.status,
      medicalTitle: medicalTitle ?? this.medicalTitle,
      medicalHistories: medicalHistories ?? this.medicalHistories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [status, medicalTitle, medicalHistories, errorMessage];
}
