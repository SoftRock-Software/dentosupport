import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditClinicController extends GetxController {
  RxBool isActiveClinicName = false.obs;
  RxBool isActivePhoneName = false.obs;
  RxBool isActiveLocation = false.obs;
  RxBool isActiveClinicsOff = false.obs;
  RxString daySelect = "".obs;
  TextEditingController clinicName = TextEditingController();
  TextEditingController clinicPhoneNumber = TextEditingController();
  TextEditingController clinicLocation = TextEditingController();
  var offDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
}
