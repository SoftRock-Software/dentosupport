import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  const SignupResponse({
    required this.status,
    required this.data,
    required this.user,
    required this.message,
    required this.token,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  final String status;
  final String message;
  final Data data;
  final String? user;
  final String token;

  Login toEntity() => Login(token: token, user: user);
}

@JsonSerializable()
class Data {
  const Data({
    required this.name,
    required this.email,
    required this.mobile,
    required this.id,
    required this.gender,
    required this.dob,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  final String name;
  final String email;
  final String mobile;
  final int id;
  final String gender;
  final String dob;
}
