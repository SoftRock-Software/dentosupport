part of 'clinic_cubit.dart';

enum ClinicStatus { initial, loading, success, failure }

class ClinicState extends Equatable {
  const ClinicState({
    this.status = ClinicStatus.initial,
    this.errorMessage = '',
  });

  final ClinicStatus status;
  final String errorMessage;

  ClinicState copyWith({
    ClinicStatus? status,
    String? errorMessage,
  }) {
    return ClinicState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
