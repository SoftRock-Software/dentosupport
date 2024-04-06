import 'package:get/get.dart';

import '../controllers/user_setting_screen_controller.dart';

class UserSettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSettingScreenController>(
      () => UserSettingScreenController(),
    );
  }
}
