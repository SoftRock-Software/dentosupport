import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  const VerifyOtpResponse({
    required this.status,
    // required this.data,
    required this.user,
    required this.message,
    required this.token,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  final String status;
  final String message;
  // final Data data;
  final String user;
  final String token;

  Login toEntity() => Login(token: token, user: user);
}

@JsonSerializable()
class Data {
  const Data({
    required this.verifyId,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @JsonKey(name: 'verify_id')
  final String verifyId;

  final String message;
}
