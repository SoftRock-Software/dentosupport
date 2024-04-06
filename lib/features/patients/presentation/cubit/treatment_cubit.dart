import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/extensions/list_extension.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'treatment_state.dart';

class TreatmentCubit extends Cubit<TreatmentState> {
  TreatmentCubit(this.patientId)
      : super(
          TreatmentState(
            title: 'Add Treatment',
            suggestedTreatments: SuggestedTreatment.make(),
          ),
        ) {
    _repository = PatientRepository(getIt());
  }

  late PatientRepository _repository;
  final int patientId;

  String _treatmentTitle = '';
  List<String> teethNumber = [];
  List<String> childTeethNumber = [];
  List<String> upperRightTeethNumber = [];
  List<String> upperLeftTeethNumber = [];
  List<String> lowerLeftTeethNumber = [];
  List<String> lowerRightTeethNumber = [];

  String get teethNumberString => getToothList(teethNumber).join(', ');

  final List<SuggestedTreatment> _suggestedTreatments =
      SuggestedTreatment.make();

  void updateAppTitle(String title) {
    emit(state.copyWith(title: title));
  }

  String treatmentName() => _treatmentTitle;

  void onTreatmentChanged(String treatment) {
    _treatmentTitle = treatment;
    final suggestedTreatments = _suggestedTreatments
        .where(
          (element) =>
              element.name.toLowerCase().contains(treatment.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(suggestedTreatments: suggestedTreatments));
  }

  void onTreatmentCostChanged(String cost) {
    var tCost = 0.0;
    if (cost.isNotEmpty) {
      tCost = double.parse(cost);
    }
    emit(state.copyWith(tratmentCost: tCost));
  }

  Future<void> addTreatment() async {
    try {
      final clinicId = getIt<LocalStorageService>().user.clinics.first.id;

      final params = AddTreatmentParams(
        name: _treatmentTitle,
        amount: state.tratmentCost,
        toothNumber: teethNumber.sorted((a, b) => a.compareTo(b)).join(', '),
        clinicId: clinicId,
        patientId: patientId,
      );
      await _repository.addTreatment(params);

      emit(
        state.copyWith(
          status: TreatmentStatus.success,
          errorMessage: 'Treatment added successfully',
        ),
      );
    } on AppResponseException catch (exception) {
      emit(
        state.copyWith(
          status: TreatmentStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: TreatmentStatus.failure,
          errorMessage: 'Something went wrong, please try again later',
        ),
      );
    }
  }

  void selectTreatment(String name) {
    final suggestedTreatments = state.suggestedTreatments
        .map(
          (element) => element.name == name
              ? element.copyWith(selected: true)
              : element.copyWith(selected: false),
        )
        .toList();
    _treatmentTitle = name;
    emit(state.copyWith(suggestedTreatments: suggestedTreatments));
  }
}

class SuggestedTreatment extends Equatable {
  const SuggestedTreatment({
    required this.name,
    this.selected = false,
  });

  final String name;
  final bool selected;

  SuggestedTreatment copyWith({
    String? name,
    bool? selected,
  }) {
    return SuggestedTreatment(
      name: name ?? this.name,
      selected: selected ?? this.selected,
    );
  }

  static List<SuggestedTreatment> make() => const [
        SuggestedTreatment(name: 'Consultation'),
        SuggestedTreatment(name: 'Xray'),
        SuggestedTreatment(name: 'Scaling'),
        SuggestedTreatment(name: 'Metal Braces'),
        SuggestedTreatment(name: 'Ceramic Braces'),
        SuggestedTreatment(name: 'Lingual Braces'),
        SuggestedTreatment(name: 'Clear Aligners'),
        SuggestedTreatment(name: 'Complete Denture'),
        SuggestedTreatment(name: 'Removable Partial Denture'),
        SuggestedTreatment(name: 'Cast Partial Denture'),
        SuggestedTreatment(name: 'Crown'),
        SuggestedTreatment(name: 'Bridge'),
        SuggestedTreatment(name: 'Implant'),
        SuggestedTreatment(name: 'Root Canal Treatment'),
        SuggestedTreatment(name: 'Composite Restoration'),
        SuggestedTreatment(name: 'GIC Restoration'),
        SuggestedTreatment(name: 'Silver Amalgam Restoration'),
        SuggestedTreatment(name: 'Post & Core'),
        SuggestedTreatment(name: 'Inlay'),
        SuggestedTreatment(name: 'Onlay'),
        SuggestedTreatment(name: 'Whitening'),
        SuggestedTreatment(name: 'Extraction'),
        SuggestedTreatment(name: 'Disimpaction'),
        SuggestedTreatment(name: 'Minor Surgical Procedure'),
        SuggestedTreatment(name: 'Gingival Flap Surgery'),
        SuggestedTreatment(name: 'Pulpectomy'),
        SuggestedTreatment(name: 'Pulpotomy'),
        SuggestedTreatment(name: 'Restorations'),
        SuggestedTreatment(name: 'Metal Crown'),
      ];

  @override
  List<Object?> get props => [name, selected];
}
