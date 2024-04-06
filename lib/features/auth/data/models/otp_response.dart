import 'package:dento_support/features/auth/domain/entities/otp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  const OtpResponse({
    required this.status,
    required this.message,
    this.token = '',
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  final String status;
  final String message;
  final Data? data;
  final String? token;

  Otp toEntity() => Otp(
        verifyId: data?.verifyId ?? '',
        token: token ?? '',
        status: status,
        message: message,
      );
}

@JsonSerializable()
class Data {
  const Data({
    required this.verifyId,
    required this.to,
    required this.flowId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @JsonKey(name: 'verify_id')
  final String verifyId;

  final To to;

  @JsonKey(name: 'flow_id')
  final String flowId;
}

@JsonSerializable()
class To {
  const To({
    required this.mobile,
  });

  factory To.fromJson(Map<String, dynamic> json) => _$ToFromJson(json);

  final String mobile;
}
