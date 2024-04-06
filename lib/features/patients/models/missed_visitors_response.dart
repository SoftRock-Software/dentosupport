import 'package:dento_support/features/patients/models/visitor_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'missed_visitors_response.g.dart';

@JsonSerializable()
class MissedVisitorsResponse {
  const MissedVisitorsResponse({
    required this.status,
    required this.data,
  });

  factory MissedVisitorsResponse.fromJson(Map<String, dynamic> json) =>
      _$MissedVisitorsResponseFromJson(json);

  final String status;
  @JsonKey(name: 'data')
  final List<Row> data;
}
