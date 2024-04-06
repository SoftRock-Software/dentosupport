import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:dento_support/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:dento_support/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.authRemoteDatasource);

  final AuthRemoteDatasource authRemoteDatasource;

  @override
  Future<Login> verifyOtp(LoginParams params) async {
    try {
      final response = await authRemoteDatasource.login(params);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Otp> sendOtp(OtpParams params) async {
    try {
      final response = await authRemoteDatasource.sendOtp(params);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Login> signup(RegisterParams params) async {
    try {
      final response = await authRemoteDatasource.signup(params);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getMe() async {
    try {
      final response = await authRemoteDatasource.getMe();
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
