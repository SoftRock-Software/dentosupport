// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistory _$MedicalHistoryFromJson(Map<String, dynamic> json) =>
    MedicalHistory(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$MedicalHistoryToJson(MedicalHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'selected': instance.selected,
    };
