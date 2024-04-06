import 'package:dento_support/features/auth/domain/domain.dart';

class PostSignup {
  const PostSignup(this.repository);

  final AuthRepository repository;

  Future<Login> call(RegisterParams params) => repository.signup(params);
}

class RegisterParams {
  const RegisterParams({
    required this.name,
    required this.email,
    // required this.about,
    required this.dob,
    required this.gender,
    this.appVersion,
    this.device,
  });

  final String name;
  final String email;
  // final String about;
  final String dob;
  final String gender;
  final String? appVersion;
  final String? device;

  RegisterParams copyWith({
    String? name,
    String? email,
    String? dob,
    String? gender,
    String? appVersion,
    String? device,
  }) {
    return RegisterParams(
      name: name ?? this.name,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      appVersion: appVersion ?? this.appVersion,
      device: device ?? this.device,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'gender': gender,
        'dob': dob,
        if (appVersion != null) 'appVersion': appVersion,
        if (device != null) 'device': device,
      };
}
