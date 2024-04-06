// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentResponse _$TreatmentResponseFromJson(Map<String, dynamic> json) =>
    TreatmentResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Treatment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TreatmentResponseToJson(TreatmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
