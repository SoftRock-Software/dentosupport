import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/widgets/app_button.dart';
import 'package:Dentosupport_mini/src/view/authorization/otp/view/otp_screen.dart';
import 'package:Dentosupport_mini/src/view/editprofile/controller/edit_profile_controller.dart';
import 'package:Dentosupport_mini/src/view/usersetting/view/user_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../global/widgets/text_field.dart';
import '../../paymentsubscription/view/payment_subscription_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "User Settings",
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
      body: Form(
        key: editProfileController.editProfileValidation,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                  commonTextField(
                    hintText: AppString.enterYourFullName,
                    controller: editProfileController.fullNameController,
                    hintTextBold: true,
                    titleTextBold: true,
                    needValidation: true,
                    isActive: editProfileController.isActiveName.value,
                    onPressed: () {
                      editProfileController.isActiveName.value = true;
                    },
                    validationMessage: "Name",
                    labelText: AppString.enterYourFullName,
                  ),
                  commonTextField(
                    hintText: AppString.gmailExample,
                    controller: editProfileController.emailController,
                    hintTextBold: true,
                    titleTextBold: true,
                    needValidation: true,
                    isEmailValidation: true,
                    upperCaseTextFormatter: false,
                    validationMessage: "Email",
                    labelText: AppString.gmailExample,
                    isActive: editProfileController.isActiveEmail.value,
                    onPressed: () {
                      editProfileController.isActiveEmail.value = true;
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
                  Row(
                    children: [
                      Expanded(
                        child: commonTextField(
                          hintText: AppString.enterYourPhoneNo,
                          labelText: AppString.enterYourPhoneNo,
                          isActive: editProfileController.isActivePhone.value,
                          onPressed: () {
                            editProfileController.isActivePhone.value = true;
                          },
                          controller: editProfileController.phoneController,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          validationMessage: "Phone Number",
                          isPhoneValidation: true,
                          showNumber: true,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: Text(
                          "Verify",
                          style: TextStyle(
                            color: AppColor.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Row(
              children: [
                Spacer(),
                AppButton(
                    onPressed: () {
                      if (editProfileController
                          .editProfileValidation.currentState!
                          .validate()) {

                      }
                    },
                    text: "Save"),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
