import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  const UserResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  final String status;
  final String message;
  final Data data;

  User toEntity() => User(
        name: data.name,
        email: data.email,
        mobile: data.mobile,
        id: data.id,
        about: data.about ?? '',
        dob: data.dob,
        gender: data.gender,
        clinics: data.clinics,
      );
}

@JsonSerializable()
class Data {
  const Data({
    required this.name,
    required this.email,
    required this.mobile,
    required this.id,
    required this.profilePic,
    required this.about,
    required this.appVersion,
    required this.device,
    required this.dob,
    required this.gender,
    required this.fcmToken,
    this.clinics = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  final String name;
  final String email;
  final String mobile;
  final int id;
  final String? profilePic;
  final String? about;
  final String? appVersion;
  final String? device;
  final String dob;
  final String gender;
  @JsonKey(name: 'FcmToken')
  final String? fcmToken;
  final List<Clinic> clinics;
}
