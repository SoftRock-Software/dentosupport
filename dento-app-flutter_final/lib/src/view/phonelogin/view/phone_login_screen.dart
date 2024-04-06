import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/global/widgets/app_button.dart';
import 'package:Dentosupport_mini/global/widgets/custom_dialogs.dart';
import 'package:Dentosupport_mini/global/widgets/text_field.dart';
import 'package:Dentosupport_mini/main.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:Dentosupport_mini/src/view/phonelogin/controller/phone_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneLoginView extends GetWidget<PhoneLoginController> {
  const PhoneLoginView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAsset.arrowBackPng,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MySize.safeHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.dento,
                      style: TextStyle(
                        color: AppColor.blue,
                        fontSize: MySize.getHeight(36),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      AppString.support,
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: MySize.getHeight(36),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppString.yourDigitalNotebook,
                  style: TextStyle(
                    color: AppColor.red,
                    fontSize: MySize.getHeight(16),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MySize.getWidth(20)),
                        child: commonTextField(
                          hintText: AppString.enterYourPhoneNo,
                          labelText: AppString.enterYourPhoneNo,
                          isActive: controller.isActivePhone.value,
                          onPressed: () {
                            controller.isActivePhone.value = true;
                          },
                          controller: controller.phoneNumberController.value,
                          hintTextBold: true,
                          titleTextBold: true,
                          needValidation: true,
                          numberTextFormatter: true,
                          maxLength: 10,
                          isPhoneValidation: true,
                          validationMessage: AppString.enterYourPhoneNo,
                          inputFormatters: [maskFormatterForMobileNumber],
                          showNumber: true,
                          autofocus: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    CircularDialogWithoutDismiss.showLoadingDialog(
                      context,
                    );
                    Get.lazyPut<SignUpController>(() => SignUpController());
                    verifyMobileNumber(
                      context: context,
                      countryCode: "+91",
                      mobileNumber: controller.phoneNumberController.value.text,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      16,
                    ),
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: MySize.getHeight(1),
                          blurRadius: MySize.getHeight(1),
                          offset:
                              Offset(MySize.getHeight(3), MySize.getHeight(3)),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
