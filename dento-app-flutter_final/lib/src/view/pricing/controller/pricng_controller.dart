import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:get/get.dart';

class PricingController extends GetxController {
  RxInt selectPlan = 1.obs;

  RxList pricingPlan = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    pricingPlan.value = [
      {
        "title": AppString.dayFreeTrial,
        "description": AppString.noCreditDebit,
      },
      {
        "title": AppString.firstPricingPlan,
        "description": AppString.noCreditDebit,
      },
      {
        "title": AppString.secondPricingPlan,
        "description": AppString.noCreditDebit,
      },
    ];
  }
}
