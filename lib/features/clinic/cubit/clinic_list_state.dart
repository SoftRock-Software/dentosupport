part of 'clinic_list_cubit.dart';

enum ClinicListStatus { initial, success, failure }

class ClinicListState extends Equatable {
  const ClinicListState({
    this.status = ClinicListStatus.initial,
    this.clinics = const [],
  });

  final ClinicListStatus status;
  final List<Clinic> clinics;

  ClinicListState copyWith({
    ClinicListStatus? status,
    List<Clinic>? clinics,
  }) {
    return ClinicListState(
      status: status ?? this.status,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  List<Object> get props => [status, clinics];
}
