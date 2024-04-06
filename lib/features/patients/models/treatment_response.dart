import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment_response.g.dart';

@JsonSerializable()
class TreatmentResponse {
  const TreatmentResponse({
    required this.status,
    required this.data,
  });

  factory TreatmentResponse.fromJson(Map<String, dynamic> json) =>
      _$TreatmentResponseFromJson(json);

  final String status;
  final List<Treatment> data;
}
