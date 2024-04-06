// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitors_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorsCountResponse _$VisitorsCountResponseFromJson(
        Map<String, dynamic> json) =>
    VisitorsCountResponse(
      status: json['status'] as String,
      featurePatientCount: (json['featurePatientCount'] as List<dynamic>)
          .map((e) => PatientCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      missPatientCount: (json['missPatientCount'] as List<dynamic>)
          .map((e) => PatientCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisitorsCountResponseToJson(
        VisitorsCountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'featurePatientCount': instance.featurePatientCount,
      'missPatientCount': instance.missPatientCount,
    };

PatientCount _$PatientCountFromJson(Map<String, dynamic> json) => PatientCount(
      date: DateTime.parse(json['date(`date`)'] as String),
      count: json['count'] as int,
    );

Map<String, dynamic> _$PatientCountToJson(PatientCount instance) =>
    <String, dynamic>{
      'date(`date`)': instance.date.toIso8601String(),
      'count': instance.count,
    };
