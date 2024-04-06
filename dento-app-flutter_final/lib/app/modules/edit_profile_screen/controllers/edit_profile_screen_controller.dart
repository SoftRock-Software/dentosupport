import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/controllers/add_patient_and_home_screen_controller.dart';
import 'package:Dentosupport_mini/global/data/NetworkClient.dart';
import 'package:Dentosupport_mini/global/models/add_patient_data_model.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/global/widgets/custom_dialogs.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

import '../../../../global/constants/api_constant.dart';
import '../../../../main.dart';

class EditProfileScreenController extends GetxController {
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;

  RxString fullNameOnChange = "".obs;
  RxBool fullNameOnFocus = false.obs;
  RxString clinicNameOnChange = "".obs;
  RxBool clinicNameOnFocus = false.obs;
  RxString clinicPhoneNumberOnChange = "".obs;
  RxBool clinicPhoneNumberOnFocus = false.obs;
  RxString clinicLocationOnChange = "".obs;
  RxBool clinicLocationOnFocus = false.obs;

  TextEditingController clinicName = TextEditingController();
  TextEditingController clinicPhoneNumber = TextEditingController();
  TextEditingController clinicLocation = TextEditingController();

  RxBool isActiveName = false.obs;
  RxBool isActiveEmail = false.obs;
  RxBool isActivePhone = false.obs;

  RxBool isActiveClinicName = false.obs;
  RxBool isActivePhoneName = false.obs;
  RxBool isActiveLocation = false.obs;
  RxBool isActiveClinicsOff = false.obs;

  RxString daySelect = "None".obs;
  var offDays = [
    'None',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final editProfileValidation = GlobalKey<FormState>();

  AddPatientAndHomeScreenController addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();

  // RxBool isMobileNumberVerified = false.obs;

  @override
  void onInit() {
    fullNameController.value.text = box.read(ArgumentConstant.userName);
    fullNameOnChange.value = box.read(ArgumentConstant.userName);
    emailController.value.text = box.read(ArgumentConstant.userEmail);
    phoneController.value.text = box.read(ArgumentConstant.userMobileNumber);
    clinicName.text = box.read(ArgumentConstant.clinicName);
    clinicNameOnChange.value = box.read(ArgumentConstant.clinicName);
    clinicPhoneNumber.text = box.read(ArgumentConstant.clinicMobile);
    clinicPhoneNumberOnChange.value = box.read(ArgumentConstant.clinicMobile);
    clinicLocation.text = box.read(ArgumentConstant.clinicLocation);
    clinicLocationOnChange.value = box.read(ArgumentConstant.clinicLocation);
    daySelect.value = box.read(ArgumentConstant.clinicDayOff);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  editProfileApi({required BuildContext context}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = fullNameController.value.text.trim();
    dict["mobile"] = phoneController.value.text.trim();
    dict["mobileUid"] = box.read(ArgumentConstant.mobileUid);
    FormData formData = FormData.fromMap(dict);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.user,
      MethodType.Patch,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (
        response,
        message,
      ) {
        FocusManager.instance.primaryFocus!.unfocus();
        // getIt<CustomDialogs>().hideCircularDialog(context);
        debugPrint("-=-=-=-=-$response");
        if (response["status"] == 200 || response["status"] == "success") {
          /*getIt<CustomDialogs>()
              .getDialog(title: "Success", desc: response["message"]);*/
          box.write(ArgumentConstant.userMobileNumber,
              phoneController.value.text.toString().trim());

          /*addPatientAndHomeScreenController.callGetMeApi(context: Get.context!);
          Get.close(3);*/
          callEditClinicApi(
            context: Get.context!,
          );
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        FocusManager.instance.primaryFocus!.unfocus();
        debugPrint("-=-=-=-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callEditClinicApi({required BuildContext context}) async {
    Map<String, dynamic> dict = {};
    dict["name"] = clinicName.text.trim();
    dict["mobile"] = int.parse(clinicPhoneNumber.text);
    dict["location"] = clinicLocation.text.trim();
    dict["dayOff"] = (daySelect.value == "None") ? "" : daySelect.value;

    debugPrint("-=-=dict-=-$dict");
    debugPrint("-=-=dict-=-${ApiConstant.addClinic}");
    debugPrint("-=-=dict-=-$baseUrl");
    debugPrint("-=-=dict-=-$dict");

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      "${ApiConstant.addClinic}/${box.read(ArgumentConstant.clinicId).toString()}",
      MethodType.Patch,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (
        response,
        message,
      ) {
        debugPrint("-successCallback=-=response-=-$response");
        debugPrint("-=-=dict-=-$dict");

        if (response["status"] == 200 || response["status"] == "success") {
          getIt<CustomDialogs>().hideCircularDialog(context);
          // AddPatientDataModel res = AddPatientDataModel.fromJson(response);

          debugPrint("-=-=response-=-$response");
          debugPrint("-=-=dict-=-$dict");

          // addPatientAndHomeScreenController.callGetMeApi(context: Get.context!);
          Get.offAllNamed(
            Routes.ADD_PATIENT_AND_HOME_SCREEN,
          );
          // Get.close(2);

          /*getIt<CustomDialogs>()
              .getDialog(title: "Success", desc: response["message"])
              .whenComplete(() => addPatientAndHomeScreenController.refresh());*/
        } else {
          debugPrint("-else=-=response-=-$response");
          debugPrint("-=-=dict-=-$dict");
          getIt<CustomDialogs>().hideCircularDialog(context);

          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        debugPrint("-failureCallback=-=response-=-$response");
        debugPrint("-=-=dict-=-$dict");

        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
