import 'package:Dentosupport_mini/src/view/pricing/controller/pricng_controller.dart';
import 'package:get/get.dart';

class PricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PricingController>(
      () => PricingController(),
    );
  }
}
