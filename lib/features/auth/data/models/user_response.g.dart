// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      id: json['id'] as int,
      profilePic: json['profilePic'] as String?,
      about: json['about'] as String?,
      appVersion: json['appVersion'] as String?,
      device: json['device'] as String?,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      fcmToken: json['FcmToken'] as String?,
      clinics: (json['clinics'] as List<dynamic>?)
              ?.map((e) => Clinic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'id': instance.id,
      'profilePic': instance.profilePic,
      'about': instance.about,
      'appVersion': instance.appVersion,
      'device': instance.device,
      'dob': instance.dob,
      'gender': instance.gender,
      'FcmToken': instance.fcmToken,
      'clinics': instance.clinics,
    };
