// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextSchedule _$NextScheduleFromJson(Map<String, dynamic> json) => NextSchedule(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$NextScheduleToJson(NextSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
    };
