import 'dart:async';

import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/models/add_patient_data_model.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/global/widgets/account_already_dialog.dart';
import 'package:Dentosupport_mini/src/view/splash/controller/splash_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../global/data/NetworkClient.dart';
import '../../../../../global/models/signup_response_model.dart';
import '../../../../../global/widgets/custom_dialogs.dart';
import '../../../../../main.dart';
import '../../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  SplashController splashScreenController = Get.put(SplashController());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController clinicName = TextEditingController();
  TextEditingController clinicPhoneNumber = TextEditingController();
  TextEditingController clinicLocation = TextEditingController();

  RxString fullNameOnChange = "".obs;
  RxBool fullNameOnFocus = false.obs;
  RxString clinicNameOnChange = "".obs;
  RxBool clinicNameOnFocus = false.obs;
  RxString clinicPhoneNumberOnChange = "".obs;
  RxBool clinicPhoneNumberOnFocus = false.obs;
  RxString clinicLocationOnChange = "".obs;
  RxBool clinicLocationOnFocus = false.obs;

  final signUpValidation = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  RxBool isActiveName = false.obs;
  RxBool isActiveEmail = false.obs;
  RxBool isActivePhone = false.obs;
  RxBool isActiveClinicName = false.obs;
  RxBool isActivePhoneName = false.obs;
  RxBool isActiveLocation = false.obs;
  RxBool isActiveClinicsOff = false.obs;

  RxBool isMobileNumberVerified = false.obs;

  RxBool isRead = false.obs;

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

  @override
  void onInit() {
    if (!isNullEmptyOrFalse(box.read(ArgumentConstant.userEmail))) {
      emailController.text = box.read(ArgumentConstant.userEmail);
    }
    if (!isNullEmptyOrFalse(box.read(ArgumentConstant.userName))) {
      fullNameController.text = box.read(ArgumentConstant.userName);
      fullNameOnChange.value = box.read(ArgumentConstant.userName);
    }
    if (!isNullEmptyOrFalse(box.read(ArgumentConstant.userMobileNumber))) {
      phoneNumberController.text = box
          .read(ArgumentConstant.userMobileNumber)
          .toString()
          .replaceAll("+91", "");
    }

    super.onInit();
  }

  mobileCheck({
    required BuildContext context,
    String? mobileNumber,
    bool? isSwitchAccount,
    bool? isJustCheck = false,
  }) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["mobile"] = mobileNumber;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.mobileCheck,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=request-=-${ApiConstant.mobileCheck}");
        debugPrint("-=-=-=dict-=-$dict");
        debugPrint("-=-=-=response-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          if (response["message"] == "user not available") {
            debugPrint("-=-=-=-${mobileNumber!}");
            if (isJustCheck == true) {
            } else {
              verifyMobileNumber(
                context: context,
                mobileNumber: mobileNumber,
                countryCode: "+91",
              );
            }
          } else {
            if ("${response["message"]}".toLowerCase() == "user available") {
              // String number = "=+911234567890";
              String email = "${response["email"].toString().split("@").first}";
              // String email = "abhika";
              // String email = "abhik";
              // String email = "abhi";
              // String email = "abh";
              // String email = "ab";
              // String email = "a";

              // String newNumber = number;
              String newEmail = email;

              /*String replaceCharAt(
                    String oldString, int index, String newChar) {
                  return oldString.substring(0, index) +
                      newChar +
                      oldString.substring(index + 1);
                }
                for (int i = 6; i < number.length; i++) {
                  newNumber = replaceCharAt(newNumber, i, "*");
                  print("PHONE_NUMBER_LOOP:$newNumber");
                }*/

              String replaceEmailCharAt(
                  String oldString, int index, String newChar) {
                return oldString.substring(0, index) +
                    newChar +
                    oldString.substring(index + 1);
              }

              if (email.length > 4) {
                debugPrint("PHONE_NUMBER_LOOP 1:");
                for (int i = 3; i < email.length - 1; i++) {
                  newEmail = replaceEmailCharAt(newEmail, i, "*");
                  print("PHONE_NUMBER_LOOP 1:$newEmail");
                }
              } else if (email.length < 3) {
                debugPrint("PHONE_NUMBER_LOOP 2:");
                if (email.length == 2) {
                  for (int i = 0; i < email.length - 1; i++) {
                    newEmail = replaceEmailCharAt(newEmail, i, "*");
                    print("PHONE_NUMBER_LOOP 2:$newEmail");
                  }
                } else {
                  debugPrint("PHONE_NUMBER_LOOP 3:");
                  for (int i = 0; i < email.length; i++) {
                    newEmail = replaceEmailCharAt(newEmail, i, "*");
                    print("PHONE_NUMBER_LOOP 3:$newEmail");
                  }
                }
              } else {
                debugPrint("PHONE_NUMBER_LOOP 4:");
                for (int i = 1; i < email.length - 1; i++) {
                  newEmail = replaceEmailCharAt(newEmail, i, "*");
                  print("PHONE_NUMBER_LOOP 4:$newEmail");
                }
              }

              // print("---FinalNumber:$newNumber");
              print("---FinalNumber:$newEmail");

              if (isSwitchAccount == true) {
                Get.generalDialog(
                  barrierDismissible: false,
                  pageBuilder: (context, animation, secAnimation) {
                    return AccountAlreadyDialog(
                      email: "$newEmail@gmail.com",
                      // email: response["email"],
                      mobileNumber: mobileNumber.toString(),
                      onCancel: () {
                        Get.back();
                      },
                      onDone: () {
                        getIt<CustomDialogs>().showCircularDialog(context);
                        getLogOutNoRoute();
                        /* GoogleSignIn signIn = GoogleSignIn();
                      signIn.signOut();
                      clearBox();*/
                        Future.delayed(
                          const Duration(milliseconds: 1000),
                          () {
                            getIt<CustomDialogs>().hideCircularDialog(context);
                            splashScreenController.signInWithGoogle(
                                context: context);
                          },
                        );
                      },
                      continueWith: () {
                        phoneNumberController.clear();
                        Get.back();
                      },
                    );
                  },
                );
              } else {
                getIt<CustomDialogs>().getUserAvailableDialog(
                  title: "Failed",
                  // email: "abhikatrodiya11@gmail.com",
                  // email: response["email"],
                  email: "$newEmail@gmail.com",
                );
              }
            } else {
              getIt<CustomDialogs>()
                  .getDialog(title: "Failed", desc: response["message"]);
            }
          }
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        debugPrint("-=-=-=-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>().getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callSignUpApi({required BuildContext context}) async {
    debugPrint("-=-=-=-callSignUpApi");
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = fullNameController.text;
    dict["email"] = emailController.text;
    dict["mobile"] = phoneNumberController.text;
    dict["emailUid"] = box.read(ArgumentConstant.emailUid);
    dict["mobileUid"] = box.read(ArgumentConstant.mobileUid);
    debugPrint("-=-=-=-$dict");
    debugPrint("-=-=-=-$baseUrl");
    debugPrint("-=-=-=-${ApiConstant.signUp}");
    FormData formData = FormData.fromMap(dict);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.signUp,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: formData,
      successCallback: (
        response,
        message,
      ) {
        debugPrint("-=-=-=-$response");
        if (/*response["status"] == 200 || */ response["status"] == "success") {
          SignUpDataModel res = SignUpDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.token)) {
            box.write(ArgumentConstant.token, res.token!);
            box.write(ArgumentConstant.firstTimeSignUp, true);
            box.write(ArgumentConstant.userAlreadyLogin, true);
          }
          if (!isNullEmptyOrFalse(res.data)) {
            if (!isNullEmptyOrFalse(res.data!.id)) {
              box.write(ArgumentConstant.userId, res.data!.id.toString());
            }
            if (!isNullEmptyOrFalse(res.data!.profilePic)) {
              box.write(ArgumentConstant.userProfilePic,
                  res.data!.profilePic.toString());
            }
          }
          callAddClinicApi(context: context);
        } else {
          getIt<CustomDialogs>().hideCircularDialog(context);
          // callAddClinicApi(context: context);
          Get.offAllNamed(Routes.SPLASH_SCREEN);
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        debugPrint("-=-=-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddClinicApi({required BuildContext context}) async {
    debugPrint("-=-=-=-callAddClinicApi");
    Map<String, dynamic> dict = {};
    dict["name"] = clinicName.text;
    dict["mobile"] = int.parse(clinicPhoneNumber.text);
    dict["location"] = clinicLocation.text;
    dict["dayOff"] = (daySelect.value == "None") ? "" : daySelect.value;

    debugPrint("-=-=-=-dict-=-$dict");

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.addClinic,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-response-=-$response");
        if (response["status"] == 200 || response["status"] == "success") {
          getIt<CustomDialogs>().hideCircularDialog(context);
          AddPatientDataModel res = AddPatientDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.data)) {
            if (!isNullEmptyOrFalse(res.data!.id)) {
              box.write(ArgumentConstant.userId, res.data!.id.toString());
              Get.offAllNamed(
                Routes.ADD_PATIENT_AND_HOME_SCREEN,
              );
            }
          }
        } else {
          getIt<CustomDialogs>().hideCircularDialog(context);

          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        debugPrint("-=-=-=-response-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }
}
