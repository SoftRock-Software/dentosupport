import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/auth/domain/usecases/get_user.dart';
import 'package:dento_support/features/clinic/clinic_repository.dart';
import 'package:dento_support/features/clinic/models/clinic_params.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit() : super(const ClinicState()) {
    _repository = ClinicRepository(getIt());
    _getUser = GetUser(getIt());
  }

  late ClinicRepository _repository;
  late GetUser _getUser;

  Future<void> addClinic(ClinicParams params) async {
    emit(state.copyWith(status: ClinicStatus.loading));
    try {
      await _repository.addClinic(params);
      await _updateUserClinic();
      emit(state.copyWith(status: ClinicStatus.success));
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  Future<void> editClinic(ClinicParams params, int id) async {
    emit(state.copyWith(status: ClinicStatus.loading));
    try {
      // final clinicResponse =
      await _repository.updateClinic(params, id.toString());
      await _updateUserClinic();
      emit(state.copyWith(status: ClinicStatus.success));
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  Future<void> deleteClinic(int id) async {
    emit(state.copyWith(status: ClinicStatus.loading));
    try {
      await _repository.deleteClinic(id.toString());
      await _updateUserClinic();
      emit(state.copyWith(status: ClinicStatus.success));
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  Future<void> _updateUserClinic() async {
    final user = await _getUser.call();
    await getIt<LocalStorageService>().setUser(user);
  }
}
