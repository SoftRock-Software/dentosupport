import 'dart:async';

import 'package:dento_support/core/exceptions/network_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc({
    required PostLogin postLogin,
    required SendOtp sendOtp,
    required GetUser getUser,
  })  : _postLogin = postLogin,
        _sendOtp = sendOtp,
        _getUser = getUser,
        super(const PhoneAuthState()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetEvent>(_onReset);
  }

  final SendOtp _sendOtp;
  final PostLogin _postLogin;
  final GetUser _getUser;

  late String _verifyId;

  Future<void> _onSendOtp(
    SendOtpEvent event,
    Emitter<PhoneAuthState> emit,
  ) async {
    try {
      emit(
        state.copyWith(loading: true, error: ''),
      );
      final otp = await _sendOtp.call(OtpParams(mobile: event.phoneNumber));
      if (otp.status == 'fail') {
        emit(state.copyWith(error: otp.message, loading: false));
      } else {
        _verifyId = otp.verifyId;
        getIt<LocalStorageService>().token = otp.token;
        emit(
          state.copyWith(
            status: PhoneAuthStatus.otpSent,
            otpSent: true,
            loading: false,
            error: '',
          ),
        );
      }
    } on NetworkException catch (_) {
      emit(state.copyWith(error: 'No internet connection', loading: false));
    } catch (e) {
      debugPrint('$e');
      emit(state.copyWith(error: 'Otp Sent Failure', loading: false));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<PhoneAuthState> emit,
  ) async {
    try {
      emit(
        state.copyWith(loading: true, error: '', otpSent: false),
      );
      final login = await _postLogin
          .call(LoginParams(otp: event.smsCode, verifyId: _verifyId));
      getIt<LocalStorageService>().token = login.token;
      if (login.user == 'new') {
        emit(
          state.copyWith(
            status: PhoneAuthStatus.userNew,
            loading: false,
            error: '',
          ),
        );
      } else {
        // Get user
        final user = await _getUser.call();

        // Fetch data at patient list...

        await getIt<LocalStorageService>().setUser(user);
        getIt<LocalStorageService>().isLogin = true;

        emit(
          state.copyWith(
            status: PhoneAuthStatus.userOld,
            loading: false,
            error: '',
          ),
        );
      }
    } on NetworkException catch (_) {
      emit(state.copyWith(error: 'No internet connection', loading: false));
    } catch (e) {
      emit(state.copyWith(error: 'OTP verification failed', loading: false));
    }
  }

  FutureOr<void> _onReset(ResetEvent event, Emitter<PhoneAuthState> emit) {
    emit(const PhoneAuthState());
  }
}
