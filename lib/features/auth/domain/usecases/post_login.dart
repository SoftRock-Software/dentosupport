import 'package:dento_support/features/auth/domain/domain.dart';

class PostLogin {
  const PostLogin(this.repository);

  final AuthRepository repository;

  Future<Login> call(LoginParams params) => repository.verifyOtp(params);
}

class LoginParams {
  const LoginParams({
    required this.verifyId,
    required this.otp,
  });

  final String verifyId;
  final String otp;

  Map<String, dynamic> toJson() => {
        'verify_id': verifyId,
        'otp': otp,
      };
}
