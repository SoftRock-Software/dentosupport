import 'package:get/get.dart';

import '../controllers/add_patient_and_home_screen_controller.dart';

class AddPatientAndHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPatientAndHomeScreenController>(
      () => AddPatientAndHomeScreenController(),
    );
  }
}
