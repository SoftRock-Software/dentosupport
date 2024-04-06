part of 'search_bloc.dart';

enum SearchStatus { noSearch, search }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.noSearch,
    this.missedPatient = const [],
    this.searchResult = const [],
    this.searchTerm = '',
    this.isNotSchedule = true,
  });

  final String searchTerm;
  final SearchStatus status;
  final List<Patient> missedPatient;
  final List<SearchResult> searchResult;
  final bool isNotSchedule;

  SearchState copyWith({
    String? searchTerm,
    List<Patient>? missedPatient,
    List<SearchResult>? searchResult,
    SearchStatus? status,
    bool? isNotSchedule,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
      missedPatient: missedPatient ?? this.missedPatient,
      searchResult: searchResult ?? this.searchResult,
      status: status ?? this.status,
      isNotSchedule: isNotSchedule ?? this.isNotSchedule,
    );
  }

  @override
  List<Object> get props =>
      [missedPatient, status, searchResult, searchTerm, isNotSchedule];
}
