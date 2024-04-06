part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class MissedPatientsFetched extends SearchEvent {
  const MissedPatientsFetched();
}

class TextChanged extends SearchEvent {
  const TextChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];
}

class OpenSchedule extends SearchEvent {
  const OpenSchedule({required this.schedule});

  final bool schedule;

  @override
  List<Object> get props => [schedule];
}
