import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/widgets/app_button.dart';
import 'package:Dentosupport_mini/global/widgets/appbar.dart';
import 'package:Dentosupport_mini/global/widgets/permission.dart';
import 'package:Dentosupport_mini/global/widgets/text_field.dart';
import 'package:Dentosupport_mini/main.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../global/utils/uitilities.dart';
import '../../otp/view/otp_screen.dart';

class SingUpScreen extends GetWidget<SignUpController> {
  const SingUpScreen({Key? key}) : super(key: key);

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
          controller
              .clinicPhoneNumberOnChange.value = contact.phoneNumber!.number!
              .replaceAll("+91", "")
              .replaceAll(" ", "")
              .trim();
        }
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.greyBackground,
        appBar: appBar(
          onTap: () {},
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.signUpValidation,
            child: Obx(
              () => Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 32,
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
                        Text(
                          AppString.primaryInformation,
                          style: TextStyle(
                            color: AppColor.blackText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 4.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            AppString.pleaseEnterYourInformation,
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
                            controller.fullNameOnFocus.value = hasFocus;
                            if (hasFocus) {
                              // do stuff
                            }
                          },
                          child: commonTextField(
                            hintText: AppString.enterYourFullName,
                            controller: controller.fullNameController,
                            hintTextBold: true,
                            titleTextBold: true,
                            needValidation: true,
                            // specialCharacterHideValidation: true,
                            onlyAlphabetValidation: true,
                            isActive: controller.isActiveName.value,
                            onPressed: () {
                              controller.isActiveEmail.value = false;
                              controller.isActivePhone.value = false;
                              controller.isActiveClinicName.value = false;
                              controller.isActivePhoneName.value = false;
                              controller.isActiveLocation.value = false;
                              controller.isActiveClinicsOff.value = false;
                              controller.isActiveName.value = true;
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
                                      controller.fullNameController.clear();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: MySize.getHeight(25),
                                      width: MySize.getHeight(25),
                                      child: SvgPicture.asset(
                                          imageSvgPath +
                                              "cancel_button_pic.svg",
                                          height: MySize.getHeight(25),
                                          width: MySize.getHeight(25)),
                                    ),
                                  ),
                          ),
                        ),
                        commonTextField(
                          hintText: "Enter your mail",
                          controller: controller.emailController,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          isEmailValidation: true,
                          validationMessage: "Email",
                          labelText: "Enter email",
                          upperCaseTextFormatter: false,
                          isActive: controller.isActiveEmail.value,
                          readyOnly: !isNullEmptyOrFalse(
                              box.read(ArgumentConstant.userEmail)),
                          onPressed: () {
                            controller.isActiveName.value = false;
                            controller.isActivePhone.value = false;
                            controller.isActiveClinicName.value = false;
                            controller.isActivePhoneName.value = false;
                            controller.isActiveLocation.value = false;
                            controller.isActiveClinicsOff.value = false;
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
                        controller.isMobileNumberVerified.isTrue
                            ? commonTextField(
                                hintText: AppString.enterYourPhoneNo,
                                labelText: AppString.enterYourPhoneNo,
                                isActive: controller.isActivePhone.value,
                                onPressed: () {
                                  controller.isActiveName.value = false;
                                  controller.isActiveClinicName.value = false;
                                  controller.isActivePhoneName.value = false;
                                  controller.isActiveLocation.value = false;
                                  controller.isActiveClinicsOff.value = false;
                                  controller.isActiveEmail.value = false;
                                  controller.isActivePhone.value = true;
                                },
                                controller: controller.phoneNumberController,
                                hintTextBold: true,
                                titleTextBold: true,
                                needValidation: true,
                                readyOnly: true,
                                numberTextFormatter: true,
                                maxLength: 10,
                                // controller.isMobileNumberVerified.value,
                                // validationMessage: "Phone Number",
                                isPhoneValidation: true,
                                inputFormatters: [maskFormatterForMobileNumber],
                                showNumber: true,
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
                                        controller.isActiveName.value = false;
                                        controller.isActiveClinicName.value =
                                            false;
                                        controller.isActivePhoneName.value =
                                            false;
                                        controller.isActiveLocation.value =
                                            false;
                                        controller.isActiveClinicsOff.value =
                                            false;
                                        controller.isActiveEmail.value = false;
                                        controller.isActivePhone.value = true;
                                      },
                                      controller:
                                          controller.phoneNumberController,
                                      hintTextBold: true,
                                      titleTextBold: true,
                                      needValidation: true,
                                      numberTextFormatter: true,
                                      maxLength: 10,
                                      readyOnly: controller
                                          .isMobileNumberVerified.value,
                                      // validationMessage: "Phone Number",
                                      isPhoneValidation: true,
                                      onChangedValue: (value) {
                                        if (controller.phoneNumberController
                                            .text.length ==
                                            10) {
                                          controller.mobileCheck(
                                            context: context,
                                            mobileNumber: controller
                                                .phoneNumberController.text,
                                            isSwitchAccount: true,
                                            isJustCheck: true,
                                          );

                                          /*verifyMobileNumber(
                                        context: context,
                                        mobileNumber: controller
                                            .phoneNumberController.text,
                                        countryCode: "+91");*/
                                        }
                                      },
                                      inputFormatters: [
                                        maskFormatterForMobileNumber
                                      ],
                                      showNumber: true,
                                    ),
                                  ),
                                  /*InkWell(
                                    onTap: () {
                                      if (controller
                                          .isMobileNumberVerified.isFalse) {
                                        if (controller.phoneNumberController
                                                .text.length >=
                                            10) {
                                          controller.mobileCheck(
                                            context: context,
                                            mobileNumber: controller
                                                .phoneNumberController.text,
                                            isSwitchAccount: true,
                                          );

                                          */ /*verifyMobileNumber(
                                        context: context,
                                        mobileNumber: controller
                                            .phoneNumberController.text,
                                        countryCode: "+91");*/ /*
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(customSnackBar(
                                                  content:
                                                      "Please enter valid mobile number."));
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                        right: 16.0,
                                      ),
                                      child: (controller
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                color: (controller
                                                        .isMobileNumberVerified
                                                        .isTrue)
                                                    ? AppColor.green
                                                    : AppColor.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                    ),
                                  )*/
                                ],
                              ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 29,
                      bottom: 36,
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
                                          imageSvgPath +
                                              "cancel_button_pic.svg",
                                          height: MySize.getHeight(25),
                                          width: MySize.getHeight(25)),
                                    ),
                                  ),
                          ),
                        ),
                        Focus(
                          onFocusChange: (hasFocus) {
                            debugPrint("-=-=-hasFocus=-=-$hasFocus");
                            controller.clinicPhoneNumberOnFocus.value =
                                hasFocus;
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
                            prefixIcon: GestureDetector(
                              onTap: () {
                                _pickContact();
                              },
                              child: Icon(
                                Icons.perm_contact_calendar_outlined,
                                color: AppColor.blue,
                              ),
                            ),
                            onChangedValue: (value) {
                              controller.clinicPhoneNumberOnChange.value =
                                  value!;
                            },
                            iconButton: controller.clinicPhoneNumberOnChange
                                        .value.isEmpty ||
                                    controller.clinicPhoneNumberOnFocus.value ==
                                        false
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller
                                          .clinicPhoneNumberOnChange.value = "";
                                      controller.clinicPhoneNumber.clear();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: MySize.getHeight(25),
                                      width: MySize.getHeight(25),
                                      child: SvgPicture.asset(
                                          imageSvgPath +
                                              "cancel_button_pic.svg",
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
                            iconButton: controller
                                        .clinicLocationOnChange.value.isEmpty ||
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
                                          imageSvgPath +
                                              "cancel_button_pic.svg",
                                          height: MySize.getHeight(25),
                                          width: MySize.getHeight(25)),
                                    ),
                                  ),
                          ),
                        ),
                        daySelectView(),
                        termsAndPrivacyView(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 35.64,
                              ),
                              child: AppButton(
                                onPressed: () {
                                  if (controller.fullNameController.value.text
                                          .isEmpty /* ||
                                      controller
                                          .isMobileNumberVerified.isFalse*/
                                      ||
                                      controller.phoneNumberController
                                          .text.isEmpty ||
                                      controller
                                          .clinicName.value.text.isEmpty ||
                                      controller.clinicPhoneNumber.value.text
                                          .isEmpty ||
                                      controller
                                          .clinicLocation.value.text.isEmpty ||
                                      controller.isRead.value == false) {
                                    debugPrint("-=-=-=-IF");
                                  } else {
                                    if (controller
                                        .isMobileNumberVerified.isTrue) {
                                      if (controller
                                          .signUpValidation.currentState!
                                          .validate()) {
                                        if (!isNullEmptyOrFalse(box.read(
                                                ArgumentConstant.emailUid)) &&
                                            !isNullEmptyOrFalse(box.read(
                                                ArgumentConstant.mobileUid))) {
                                          controller.callSignUpApi(
                                              context: context);
                                        }
                                      }
                                    } else {
                                      if (controller
                                          .isMobileNumberVerified.isFalse) {
                                        if (controller.phoneNumberController
                                            .text.length >=
                                            10) {
                                          controller.mobileCheck(
                                            context: context,
                                            mobileNumber: controller
                                                .phoneNumberController.text,
                                            isSwitchAccount: true,
                                          );

                                          /*verifyMobileNumber(
                                        context: context,
                                        mobileNumber: controller
                                            .phoneNumberController.text,
                                        countryCode: "+91");*/
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(customSnackBar(
                                                  content:
                                                      "Please enter valid mobile number."));
                                        }
                                      }
                                      /*ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackBar(
                                            content:
                                                "Please verify number first..."));*/
                                    }
                                  }
                                },
                                buttonColor: controller
                                            .fullNameController
                                            .value
                                            .text
                                            .isEmpty /* ||
                                        controller
                                            .isMobileNumberVerified.isFalse*/
                                        ||
                                        controller.phoneNumberController
                                            .text.isEmpty ||
                                        controller
                                            .clinicName.value.text.isEmpty ||
                                        controller.clinicPhoneNumber.value.text
                                            .isEmpty ||
                                        controller.clinicLocation.value.text
                                            .isEmpty ||
                                        controller.isRead.value == false
                                    ? AppColor.grey
                                    : AppColor.blue,
                                text: "Submit",
                                lcPadding: 40,
                                rcPadding: 40,
                                tcPadding: 8,
                                bcPadding: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
        bottom: 67.0,
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

  termsAndPrivacyView() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Row(
          children: [
            Checkbox(
              value: controller.isRead.value,
              activeColor: AppColor.blue,
              checkColor: AppColor.white,
              focusColor: AppColor.blue,
              hoverColor: AppColor.blue,
              onChanged: (value) {
                debugPrint(
                    "-=controller.isRead.value-=-=${controller.isRead.value}");
                controller.isRead.value = !controller.isRead.value;
                debugPrint(
                    "-=controller.isRead.value-=-=${controller.isRead.value}");
              },
            ),
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'I read and agree with ',
                  style: TextStyle(
                    color: AppColor.textBlue,
                    fontSize: MySize.getHeight(10),
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'terms and conditions',
                        style: TextStyle(
                          color: AppColor.textBlue,
                          fontSize: MySize.getHeight(10),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                              "https://www.dentosupport.com/Terms-of-use",
                            );
                          }),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(
                        color: AppColor.textBlue,
                        fontSize: MySize.getHeight(10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                        text: 'privacy policy',
                        style: TextStyle(
                          color: AppColor.textBlue,
                          fontSize: MySize.getHeight(10),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                              "https://www.dentosupport.com/privacy-policy",
                            );
                          }),
                    TextSpan(
                      text:
                          " of dentosupport(Lumnoverse Technologies Private Limited)",
                      style: TextStyle(
                        color: AppColor.textBlue,
                        fontSize: MySize.getHeight(10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /* Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " I read and agree with ",
                    style: TextStyle(
                      color: AppColor.textBlue,
                      fontSize: MySize.getHeight(10),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch(
                        "https://www.dentosupport.com/Terms-of-use",
                      );
                    },
                    child: Text(
                      "terms and conditions",
                      style: TextStyle(
                        color: AppColor.textBlue,
                        fontSize: MySize.getHeight(10),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    " and ",
                    style: TextStyle(
                      color: AppColor.textBlue,
                      fontSize: MySize.getHeight(10),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launch(
                        "https://www.dentosupport.com/privacy-policy",
                      );
                    },
                    child: Text(
                      "privacy policy",
                      style: TextStyle(
                        color: AppColor.textBlue,
                        fontSize: MySize.getHeight(10),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    " of dentosupport(Lumnoverse Technologies Private Limited)",
                    style: TextStyle(
                      color: AppColor.textBlue,
                      fontSize: MySize.getHeight(10),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
