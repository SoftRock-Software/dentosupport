import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:dento_support/features/auth/domain/entities/entities.dart';
import 'package:dento_support/features/auth/domain/usecases/usecases.dart';

abstract class AuthRepository {
  Future<Otp> sendOtp(OtpParams params);
  Future<Login> verifyOtp(LoginParams params);
  Future<Login> signup(RegisterParams params);
  Future<User> getMe();
}
