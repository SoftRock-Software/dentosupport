import 'package:dento_support/features/auth/domain/domain.dart';

class SendOtp {
  const SendOtp(this.repository);

  final AuthRepository repository;

  Future<Otp> call(OtpParams params) => repository.sendOtp(params);
}

class OtpParams {
  const OtpParams({
    required this.mobile,
  });

  final String mobile;

  Map<String, dynamic> toJson() => {'mobile': mobile};
}
