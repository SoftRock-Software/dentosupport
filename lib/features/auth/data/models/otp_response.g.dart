// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) => OtpResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      token: json['token'] as String? ?? '',
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtpResponseToJson(OtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      verifyId: json['verify_id'] as String,
      to: To.fromJson(json['to'] as Map<String, dynamic>),
      flowId: json['flow_id'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'verify_id': instance.verifyId,
      'to': instance.to,
      'flow_id': instance.flowId,
    };

To _$ToFromJson(Map<String, dynamic> json) => To(
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$ToToJson(To instance) => <String, dynamic>{
      'mobile': instance.mobile,
    };
