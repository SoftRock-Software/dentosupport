import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedFilter = 0.obs;
  RxList filerList = [].obs;
  TextEditingController phoneNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();

  RxBool isActivePhoneNo = false.obs;
  RxBool isActiveName = false.obs;
  RxBool isActiveAge = false.obs;
  RxString isGenderSelect = "Male".obs;

  @override
  void onInit() {
    filerList.value = [
      {
        "title": AppString.smileClinic,
        "description": AppString.kalyan,
      },
      {
        "title": AppString.divaDental,
        "description": AppString.diva,
      },
      {
        "title": AppString.divaDental,
        "description": AppString.diva,
      },
    ];
    super.onInit();
  }
}
