import 'dart:async';

import 'package:dento_support/core/constants/end_point.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/app/domain/entities/user.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          getIt<LocalStorageService>().isLogin
              ? AppState.authenticated(getIt<LocalStorageService>().user)
              : const AppState.unauthenticated(),
        ) {
    on<AppLoginRequested>(_onLoginRequested);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<UpdateFcmToken>(_updateFcmTokenToServer);
  }

  FutureOr<void> _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    getIt<LocalStorageService>().clear();
    emit(const AppState.unauthenticated());
  }

  FutureOr<void> _onLoginRequested(
    AppLoginRequested event,
    Emitter<AppState> emit,
  ) {
    emit(AppState.authenticated(event.user));
  }

  FutureOr<void> _updateFcmTokenToServer(
    UpdateFcmToken event,
    Emitter<AppState> emit,
  ) async {
    if (getIt<LocalStorageService>().isLogin) {
      try {
        await getIt<DioClient>().patch(
          EndPoint.user,
          data: {
            'FcmToken': getIt<LocalStorageService>().fcmToken,
          },
        );
      } catch (_) {}
    }
  }

  Future<bool> deleteUser() async {
    final id = getIt<LocalStorageService>().user.id;
    try {
      await getIt<DioClient>()
          .delete<Map<String, dynamic>>('${EndPoint.user}/$id');
      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  }
}
