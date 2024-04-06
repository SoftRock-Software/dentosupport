import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  const SearchResponse({
    required this.status,
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  final String status;
  @JsonKey(name: 'data')
  final List<SearchResult> data;
}

@JsonSerializable()
class SearchResult extends Equatable {
  const SearchResult({
    required this.id,
    required this.name,
    required this.mobile,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  final int id;
  final String name;
  final String mobile;

  @override
  List<Object?> get props => [id, name, mobile];
}
