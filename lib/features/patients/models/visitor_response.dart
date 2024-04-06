import 'package:dento_support/features/patients/models/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_response.g.dart';

@JsonSerializable()
class VisitorResponse {
  VisitorResponse({
    required this.status,
    required this.totalAmount,
    required this.cashAmount,
    required this.visited,
    required this.pendingVisitor,
    required this.data,
  });

  factory VisitorResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitorResponseFromJson(json);

  final String status;
  final int totalAmount;
  final int cashAmount;
  final int visited;
  final int pendingVisitor;
  final Data data;
}

@JsonSerializable()
class Data {
  Data({
    required this.count,
    required this.rows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  final int count;
  final List<Row> rows;
}

@JsonSerializable()
class Row {
  Row({
    required this.id,
    required this.date,
    required this.isCanceled,
    required this.isVisited,
    required this.clinicId,
    required this.patientId,
    required this.patient,
  });

  factory Row.fromJson(Map<String, dynamic> json) => _$RowFromJson(json);

  final int id;
  final DateTime date;
  final bool isCanceled;
  final bool isVisited;
  final int clinicId;
  final int patientId;
  final Patient patient;
}
