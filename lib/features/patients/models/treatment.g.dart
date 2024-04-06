// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treatment _$TreatmentFromJson(Map<String, dynamic> json) => Treatment(
      toothNumber: (json['toothNumber'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as int,
      name: json['name'] as String,
      amount: json['amount'] as int,
      status: json['status'] as String,
      patientId: json['patientId'] as int,
      clinicId: json['clinicId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TreatmentToJson(Treatment instance) => <String, dynamic>{
      'toothNumber': instance.toothNumber,
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'status': instance.status,
      'patientId': instance.patientId,
      'clinicId': instance.clinicId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
