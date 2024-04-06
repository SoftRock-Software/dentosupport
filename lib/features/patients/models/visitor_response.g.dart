// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorResponse _$VisitorResponseFromJson(Map<String, dynamic> json) =>
    VisitorResponse(
      status: json['status'] as String,
      totalAmount: json['totalAmount'] as int,
      cashAmount: json['cashAmount'] as int,
      visited: json['visited'] as int,
      pendingVisitor: json['pendingVisitor'] as int,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VisitorResponseToJson(VisitorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'cashAmount': instance.cashAmount,
      'visited': instance.visited,
      'pendingVisitor': instance.pendingVisitor,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      count: json['count'] as int,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => Row.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };

Row _$RowFromJson(Map<String, dynamic> json) => Row(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      isCanceled: json['isCanceled'] as bool,
      isVisited: json['isVisited'] as bool,
      clinicId: json['clinicId'] as int,
      patientId: json['patientId'] as int,
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RowToJson(Row instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'isCanceled': instance.isCanceled,
      'isVisited': instance.isVisited,
      'clinicId': instance.clinicId,
      'patientId': instance.patientId,
      'patient': instance.patient,
    };
