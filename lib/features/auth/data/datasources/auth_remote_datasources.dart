import 'package:dento_support/core/constants/end_point.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/features/auth/data/models/models.dart';
import 'package:dento_support/features/auth/domain/domain.dart';

abstract class AuthRemoteDatasource {
  Future<OtpResponse> sendOtp(OtpParams params);
  Future<VerifyOtpResponse> login(LoginParams params);
  Future<SignupResponse> signup(RegisterParams params);
  Future<UserResponse> getMe();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl(this._client);

  final DioClient _client;

  @override
  Future<VerifyOtpResponse> login(LoginParams params) async {
    // Handle all type of error here
    try {
      final response = await _client.post<Map<String, dynamic>>(
        EndPoint.verifyOtp,
        data: params.toJson(),
      );
      final result = VerifyOtpResponse.fromJson(response.data ?? {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OtpResponse> sendOtp(OtpParams params) async {
    try {
      final response = await _client
          .post<Map<String, dynamic>>(EndPoint.sendOtp, data: params.toJson());
      final result = OtpResponse.fromJson(response.data ?? {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignupResponse> signup(RegisterParams params) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        EndPoint.signup,
        data: params.toJson(),
        formRequest: true,
      );
      final result = SignupResponse.fromJson(response.data ?? {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserResponse> getMe() async {
    try {
      final response = await _client.get(EndPoint.getMe);
      final result =
          UserResponse.fromJson(response.data as Map<String, dynamic>);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
