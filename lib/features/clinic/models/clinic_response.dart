import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clinic_response.g.dart';

@JsonSerializable()
class ClinicResponse {
  const ClinicResponse({
    required this.status,
    required this.data,
  });

  factory ClinicResponse.fromJson(Map<String, dynamic> json) =>
      _$ClinicResponseFromJson(json);

  final String status;
  final List<Clinic> data;
}
