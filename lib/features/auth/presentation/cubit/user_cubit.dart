import 'package:dento_support/core/constants/end_point.dart';
import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/exceptions/network_exception.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/auth/domain/usecases/usecases.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<void> editUser({
    String name = '',
    String email = '',
    String dob = '',
    String gender = '',
  }) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      await getIt<DioClient>().patch(
        EndPoint.user,
        data: {
          'name': name,
          'email': email,
          'dob': dob,
          'gender': gender,
          'FcmToken': getIt<LocalStorageService>().fcmToken,
        },
      );

      final user = await GetUser(getIt()).call();
      await getIt<LocalStorageService>().setUser(user);

      emit(state.copyWith(status: UserStatus.success));
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: UserStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } on NetworkException catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'No internet connection',
          status: UserStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: UserStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }
}
