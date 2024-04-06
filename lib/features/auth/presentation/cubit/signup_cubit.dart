import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required PostSignup postSignup})
      : _postSignup = postSignup,
        super(const SignupState());

  final PostSignup _postSignup;

  Future<void> signUp(RegisterParams params) async {
    try {
      emit(state.copyWith(status: SignupStatus.loading));

      String? device;

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          device = 'Android';
          break;
        case TargetPlatform.iOS:
          device = 'IOS';
          break;
        // ignore: no_default_cases
        default:
          break;
      }

      final login = await _postSignup
          .call(params.copyWith(appVersion: versionName, device: device));

      getIt<LocalStorageService>().token = login.token;
      getIt<LocalStorageService>().isLogin = true;

      emit(state.copyWith(status: SignupStatus.success));
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: SignupStatus.error,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SignupStatus.error,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }
}
