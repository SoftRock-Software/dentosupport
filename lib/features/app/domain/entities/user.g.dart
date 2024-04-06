// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      id: json['id'] as int,
      about: json['about'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      clinics: (json['clinics'] as List<dynamic>?)
              ?.map((e) => Clinic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'id': instance.id,
      'about': instance.about,
      'dob': instance.dob,
      'gender': instance.gender,
      'clinics': instance.clinics.map((e) => e.toJson()).toList(),
    };
