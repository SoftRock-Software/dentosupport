// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missed_visitors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissedVisitorsResponse _$MissedVisitorsResponseFromJson(
        Map<String, dynamic> json) =>
    MissedVisitorsResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Row.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissedVisitorsResponseToJson(
        MissedVisitorsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
