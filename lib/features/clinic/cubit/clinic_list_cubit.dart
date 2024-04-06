import 'package:dento_support/features/clinic/clinic_repository.dart';
import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clinic_list_state.dart';

class ClinicListCubit extends Cubit<ClinicListState> {
  ClinicListCubit() : super(const ClinicListState()) {
    _repository = ClinicRepository(getIt());
  }

  late ClinicRepository _repository;

  Future<void> getClinic() async {
    emit(state.copyWith(status: ClinicListStatus.initial));
    try {
      final clinicResponse = await _repository.getAllClinic();
      emit(
        state.copyWith(
          status: ClinicListStatus.success,
          clinics: clinicResponse.data,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ClinicListStatus.failure));
    }
  }
}
