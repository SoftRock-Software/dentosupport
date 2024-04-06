import 'package:get/get.dart';

import '../controllers/individual_patient_screen_controller.dart';

class IndividualPatientScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualPatientScreenController>(
      () => IndividualPatientScreenController(),
    );
  }
}
