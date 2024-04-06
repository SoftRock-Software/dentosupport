part of 'patient_list_bloc.dart';

abstract class PatientListEvent extends Equatable {
  const PatientListEvent();

  @override
  List<Object> get props => [];
}

class PatientsFetched extends PatientListEvent {
  const PatientsFetched();
}

class PatientDeleted extends PatientListEvent {
  const PatientDeleted(this.id);

  final int id;
}

class UpdateVisitorCount extends PatientListEvent {
  const UpdateVisitorCount();
}

class SelectDate extends PatientListEvent {
  const SelectDate(this.calendar);

  final VisitorCalendar calendar;
}
