import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneLoginController extends GetxController {
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  RxBool isActivePhone = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
