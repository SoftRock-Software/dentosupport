import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/global/widgets/custom_dialogs.dart';
import 'package:Dentosupport_mini/global/widgets/permission.dart';
import 'package:Dentosupport_mini/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/widgets/app_button.dart';
import '../../../../global/widgets/text_field.dart';
import '../../../../src/view/authorization/signup/controller/signup_controller.dart';
import '../controllers/edit_profile_screen_controller.dart';

class EditProfileScreenView extends GetWidget<EditProfileScreenController> {
  EditProfileScreenView({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(
    SignUpController(),
  );

  final focus = FocusNode();

  _pickContact() async {
    AppPermission.askPermissions(
      onGranted: () async {
        final PhoneContact contact =
            await FlutterContactPicker.pickPhoneContact();
        // print(contact);
        print("=-=-=-=--=${contact.phoneNumber!.number}");
        if (contact.phoneNumber != null) {
          print("=-=1-=-=--=${controller.clinicPhoneNumber.text}");
          controller.clinicPhoneNumber.text = contact.phoneNumber!.number!
              .replaceAll("+91", "")
              .replaceAll(" ", "")
              .trim();
          controller.clinicPhoneNumberOnChange.value = contact
              .phoneNumber!.number!
              .replaceAll("+91", "")
              .replaceAll(" ", "")
              .trim();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: AppColor.blue, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.blue,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Form(
            key: controller.editProfileValidation,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Primary Information',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Please enter your information',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.greyText),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          debugPrint("-=-=-hasFocus=-=-$hasFocus");
                          controller.fullNameOnFocus.value = hasFocus;
                          if (hasFocus) {
                            // do stuff
                          }
                        },
                        child: commonTextField(
                          hintText: AppString.enterYourFullName,
                          controller: controller.fullNameController.value,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          onlyAlphabetValidation: true,
                          isActive: controller.isActiveName.value,
                          onPressed: () {
                            controller.isActiveName.value = true;
                            controller.isActivePhone.value = false;
                          },
                          validationMessage: "Name",
                          labelText: AppString.enterYourFullName,
                          onChangedValue: (value) {
                            controller.fullNameOnChange.value = value!;
                          },
                          iconButton: controller
                                      .fullNameOnChange.value.isEmpty ||
                                  controller.fullNameOnFocus.value == false
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    controller.fullNameOnChange.value = "";
                                    controller.fullNameController.value.clear();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MySize.getHeight(25),
                                    width: MySize.getHeight(25),
                                    child: SvgPicture.asset(
                                        imageSvgPath + "cancel_button_pic.svg",
                                        height: MySize.getHeight(25),
                                        width: MySize.getHeight(25)),
                                  ),
                                ),
                        ),
                      ),
                      commonTextField(
                        hintText: "Enter Email",
                        controller: controller.emailController.value,
                        hintTextBold: true,
                        titleTextBold: true,
                        needValidation: true,
                        isEmailValidation: true,
                        textColor: AppColor.greyText,
                        readyOnly: true,
                        upperCaseTextFormatter: false,
                        validationMessage: "Email",
                        labelText: "Email",
                        isActive: controller.isActiveEmail.value,
                        onPressed: () {
                          controller.isActiveEmail.value = true;
                        },
                        iconButton: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Verified",
                              style: TextStyle(
                                color: AppColor.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 8,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2.0,
                                right: 16,
                              ),
                              child: Image.asset(
                                AppAsset.verified,
                                height: 13,
                                width: 13,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      (signUpController.isMobileNumberVerified.isTrue ||
                              controller.phoneController.value.text ==
                                  box.read(ArgumentConstant.userMobileNumber))
                          ? commonTextField(
                              hintText: AppString.enterYourPhoneNo,
                              labelText: AppString.enterYourPhoneNo,
                              controller: controller.phoneController.value,
                              hintTextBold: true,
                              titleTextBold: true,
                              needValidation: true,
                              readyOnly: true,
                              validationMessage: AppString.enterYourPhoneNo,
                              isActive: controller.isActivePhone.value,
                              onPressed: () {
                                focus.requestFocus();
                                // controller.isActiveName.value = false;
                                // controller.isActiveEmail.value = false;
                                controller.isActivePhone.value = true;
                                signUpController.isMobileNumberVerified.value =
                                    false;
                                controller.phoneController.value.clear();
                              },
                              iconButton: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Verified",
                                    style: TextStyle(
                                      color: AppColor.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 16,
                                    ),
                                    child: Image.asset(
                                      AppAsset.verified,
                                      height: 13,
                                      width: 13,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: commonTextField(
                                    hintText: AppString.enterYourPhoneNo,
                                    labelText: AppString.enterYourPhoneNo,
                                    isActive: controller.isActivePhone.value,
                                    onPressed: () {
                                      focus.requestFocus();
                                      controller.isActiveName.value = false;
                                      // controller.isActiveEmail.value = false;
                                      controller.isActivePhone.value = true;
                                      signUpController
                                          .isMobileNumberVerified.value = false;
                                      // controller.phoneController.value.clear();
                                    },
                                    controller:
                                        controller.phoneController.value,
                                    validationMessage:
                                        AppString.enterYourPhoneNo,
                                    hintTextBold: true,
                                    maxLength: 10,
                                    titleTextBold: true,
                                    needValidation: true,
                                    focusNode: focus,
                                    readyOnly: signUpController
                                        .isMobileNumberVerified.value,
                                    // validationMessage: "Phone Number",
                                    // isPhoneValidation: true,
                                    inputFormatters: [
                                      maskFormatterForMobileNumber
                                    ],
                                    showNumber: true,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (signUpController
                                        .isMobileNumberVerified.isFalse) {
                                      if (controller.phoneController.value.text
                                              .length >=
                                          10) {
                                        if (controller
                                                .phoneController.value.text ==
                                            box.read(ArgumentConstant
                                                .userMobileNumber)) {
                                          signUpController
                                              .isMobileNumberVerified
                                              .value = true;
                                        } else {
                                          signUpController
                                                  .phoneNumberController.text =
                                              controller
                                                  .phoneController.value.text;
                                          signUpController.mobileCheck(
                                            context: context,
                                            mobileNumber: controller
                                                .phoneController.value.text,
                                            isSwitchAccount: false,
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          customSnackBar(
                                            content:
                                                "Please enter valid mobile number.",
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: (signUpController
                                            .isMobileNumberVerified.isTrue)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Verified",
                                                style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 8,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 16,
                                                ),
                                                child: Image.asset(
                                                  AppAsset.verified,
                                                  height: 13,
                                                  width: 13,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "Verify",
                                            style: TextStyle(
                                              color: (signUpController
                                                      .isMobileNumberVerified
                                                      .isTrue)
                                                  ? AppColor.green
                                                  : AppColor.blue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 13,
                    bottom: 26,
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppString.clinicDetails,
                        style: TextStyle(
                          color: AppColor.blackText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 4.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          AppString.pleaseEnterYourClinicDetails,
                          style: TextStyle(
                            color: AppColor.greyText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          debugPrint("-=-=-hasFocus=-=-$hasFocus");
                          controller.clinicNameOnFocus.value = hasFocus;
                          if (hasFocus) {
                            // do stuff
                          }
                        },
                        child: commonTextField(
                          hintText: AppString.enterClinicName,
                          labelText: AppString.enterClinicName,
                          isActive: controller.isActiveClinicName.value,
                          onPressed: () {
                            controller.isActiveName.value = false;
                            controller.isActivePhoneName.value = false;
                            controller.isActiveLocation.value = false;
                            controller.isActiveClinicsOff.value = false;
                            controller.isActiveEmail.value = false;
                            controller.isActivePhone.value = false;
                            controller.isActiveClinicName.value = true;
                          },
                          controller: controller.clinicName,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          // onlyAlphabetValidation: true,
                          validationMessage: "Clinic Name",
                          maxLength: 22,
                          onChangedValue: (value) {
                            controller.clinicNameOnChange.value = value!;
                          },
                          iconButton: controller
                                      .clinicNameOnChange.value.isEmpty ||
                                  controller.clinicNameOnFocus.value == false
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    controller.clinicNameOnChange.value = "";
                                    controller.clinicName.clear();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MySize.getHeight(25),
                                    width: MySize.getHeight(25),
                                    child: SvgPicture.asset(
                                        imageSvgPath + "cancel_button_pic.svg",
                                        height: MySize.getHeight(25),
                                        width: MySize.getHeight(25)),
                                  ),
                                ),
                        ),
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          debugPrint("-=-=-hasFocus=-=-$hasFocus");
                          controller.clinicPhoneNumberOnFocus.value = hasFocus;
                          if (hasFocus) {
                            // do stuff
                          }
                        },
                        child: commonTextField(
                          hintText: AppString.clinicPhoneName,
                          labelText: AppString.clinicPhoneName,
                          isActive: controller.isActivePhoneName.value,
                          onPressed: () {
                            controller.isActiveName.value = false;
                            controller.isActiveLocation.value = false;
                            controller.isActiveClinicsOff.value = false;
                            controller.isActiveEmail.value = false;
                            controller.isActivePhone.value = false;
                            controller.isActiveClinicName.value = false;
                            controller.isActivePhoneName.value = true;
                          },
                          // numberTextFormatter: true,
                          controller: controller.clinicPhoneNumber,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          isPhoneValidation: true,
                          maxLength: 10,

                          // inputFormatters: [maskFormatterForMobileNumber],
                          showNumber: true,
                          validationMessage: "Clinic Phone",
                          onChangedValue: (value) {
                            controller.clinicPhoneNumberOnChange.value = value!;
                          },
                          prefixIcon: GestureDetector(
                            onTap: () {
                              _pickContact();
                            },
                            child: Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: AppColor.blue,
                            ),
                          ),
                          iconButton: controller.clinicPhoneNumberOnChange.value
                                      .isEmpty ||
                                  controller.clinicPhoneNumberOnFocus.value ==
                                      false
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    controller.clinicPhoneNumberOnChange.value =
                                        "";
                                    controller.clinicPhoneNumber.clear();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MySize.getHeight(25),
                                    width: MySize.getHeight(25),
                                    child: SvgPicture.asset(
                                        imageSvgPath + "cancel_button_pic.svg",
                                        height: MySize.getHeight(25),
                                        width: MySize.getHeight(25)),
                                  ),
                                ),
                        ),
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          debugPrint("-=-=-hasFocus=-=-$hasFocus");
                          controller.clinicLocationOnFocus.value = hasFocus;
                          if (hasFocus) {
                            // do stuff
                          }
                        },
                        child: commonTextField(
                          hintText: AppString.locationOfTheClinic,
                          labelText: AppString.locationOfTheClinic,
                          isActive: controller.isActiveLocation.value,
                          onPressed: () {
                            controller.isActiveName.value = false;
                            controller.isActiveClinicsOff.value = false;
                            controller.isActiveEmail.value = false;
                            controller.isActivePhone.value = false;
                            controller.isActiveClinicName.value = false;
                            controller.isActivePhoneName.value = false;
                            controller.isActiveLocation.value = true;
                          },
                          controller: controller.clinicLocation,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          validationMessage: "Location",
                          onChangedValue: (value) {
                            controller.clinicLocationOnChange.value = value!;
                          },
                          iconButton: controller.clinicLocationOnChange.value
                              .isEmpty ||
                              controller.clinicLocationOnFocus.value ==
                                  false
                              ? SizedBox()
                              : InkWell(
                            onTap: () {
                              controller.clinicLocationOnChange.value =
                              "";
                              controller.clinicLocation.clear();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(25),
                              width: MySize.getHeight(25),
                              child: SvgPicture.asset(
                                  imageSvgPath + "cancel_button_pic.svg",
                                  height: MySize.getHeight(25),
                                  width: MySize.getHeight(25)),
                            ),
                          ),
                        ),
                      ),
                      daySelectView(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: () {
                          if (controller.editProfileValidation.currentState!
                              .validate()) {
                            if (signUpController
                                    .isMobileNumberVerified.isTrue ||
                                controller.phoneController.value.text ==
                                    box.read(
                                        ArgumentConstant.userMobileNumber)) {
                              controller.editProfileApi(
                                context: context,
                              );
                            } else {
                              getIt<CustomDialogs>().getDialog(
                                  title: "Failed",
                                  desc: "mobile number verify is required");
                            }
                          }
                        },
                        text: "Save",
                        lcPadding: 47,
                        rcPadding: 47,
                        tcPadding: 8,
                        bcPadding: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding daySelectView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 20.0,
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: AppColor.blackText,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16.0,
              ),
              contentPadding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              filled: true,
              fillColor: AppColor.whiteBackground,
              label: Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                    color: controller.isActiveClinicsOff.value == true ||
                            controller.daySelect.value != ""
                        ? AppColor.white
                        : AppColor.transparent,
                    borderRadius: BorderRadius.circular(100)),
                child: const Text(
                  AppString.clinicsDayOff,
                  style: TextStyle(
                    color: AppColor.greyText,
                    /*  backgroundColor:
                        isActive == true ? AppColor.red : AppColor.transparent,*/
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              // hintText: 'Please select expense',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            isEmpty: controller.daySelect.value == '',
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.daySelect.value == ""
                      ? null
                      : controller.daySelect.value,
                  isDense: true,
                  onTap: () {
                    controller.isActiveName.value = false;
                    controller.isActiveEmail.value = false;
                    controller.isActivePhone.value = false;
                    controller.isActiveClinicName.value = false;
                    controller.isActivePhoneName.value = false;
                    controller.isActiveLocation.value = false;
                    controller.isActiveClinicsOff.value = true;
                  },
                  onChanged: (String? newValue) {
                    controller.daySelect.value = newValue.toString();
                    state.didChange(newValue);
                    /*setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });*/
                  },
                  items: controller.offDays.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
