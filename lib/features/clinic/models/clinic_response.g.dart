// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicResponse _$ClinicResponseFromJson(Map<String, dynamic> json) =>
    ClinicResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Clinic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClinicResponseToJson(ClinicResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
