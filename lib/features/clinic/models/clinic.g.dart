// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clinic _$ClinicFromJson(Map<String, dynamic> json) => Clinic(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      dayOff:
          (json['dayOff'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['id'] as int,
      location: json['location'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'dayOff': instance.dayOff,
      'id': instance.id,
      'location': instance.location,
      'userId': instance.userId,
    };
