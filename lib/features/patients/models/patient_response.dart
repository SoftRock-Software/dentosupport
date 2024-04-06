import 'package:dento_support/features/patients/models/next_schedule.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_response.g.dart';

@JsonSerializable()
class PatientResponse {
  const PatientResponse({
    required this.status,
    required this.data,
    this.receivedPayment = 0,
    this.pendingPayment = 0,
    this.totalPayment = 0,
    this.onProcessTeeth = const [],
    this.nextSchedule,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResponseFromJson(json);

  final String status;
  final Patient data;
  final int receivedPayment;
  final int pendingPayment;
  final int totalPayment;
  final List<String> onProcessTeeth;
  final NextSchedule? nextSchedule;
}
