part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class FetchPatient extends PatientEvent {
  const FetchPatient(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
