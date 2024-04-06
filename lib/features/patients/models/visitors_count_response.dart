import 'package:json_annotation/json_annotation.dart';

part 'visitors_count_response.g.dart';

@JsonSerializable()
class VisitorsCountResponse {
  VisitorsCountResponse({
    required this.status,
    required this.featurePatientCount,
    required this.missPatientCount,
  });

  factory VisitorsCountResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitorsCountResponseFromJson(json);

  String status;
  List<PatientCount> featurePatientCount;
  List<PatientCount> missPatientCount;
}

@JsonSerializable()
class PatientCount {
  PatientCount({
    required this.date,
    required this.count,
  });

  factory PatientCount.fromJson(Map<String, dynamic> json) =>
      _$PatientCountFromJson(json);

  @JsonKey(name: 'date(`date`)')
  DateTime date;
  int count;
}
