// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponse _$VerifyOtpResponseFromJson(Map<String, dynamic> json) =>
    VerifyOtpResponse(
      status: json['status'] as String,
      user: json['user'] as String,
      message: json['message'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyOtpResponseToJson(VerifyOtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
      'token': instance.token,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      verifyId: json['verify_id'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'verify_id': instance.verifyId,
      'message': instance.message,
    };
