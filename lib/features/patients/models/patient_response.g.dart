// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      status: json['status'] as String,
      data: Patient.fromJson(json['data'] as Map<String, dynamic>),
      receivedPayment: json['receivedPayment'] as int? ?? 0,
      pendingPayment: json['pendingPayment'] as int? ?? 0,
      totalPayment: json['totalPayment'] as int? ?? 0,
      onProcessTeeth: (json['onProcessTeeth'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      nextSchedule: json['nextSchedule'] == null
          ? null
          : NextSchedule.fromJson(json['nextSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'receivedPayment': instance.receivedPayment,
      'pendingPayment': instance.pendingPayment,
      'totalPayment': instance.totalPayment,
      'onProcessTeeth': instance.onProcessTeeth,
      'nextSchedule': instance.nextSchedule,
    };
