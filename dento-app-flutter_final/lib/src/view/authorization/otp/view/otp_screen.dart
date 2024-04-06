import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:Dentosupport_mini/src/view/splash/controller/splash_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../../../../global/constants/api_constant.dart';
import '../../../../../main.dart';

class OtpView extends GetWidget<SignUpController> {
  OtpView({Key? key}) : super(key: key);

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(18),
      color: AppColor.greyBackground,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  10,
                ),
                topRight: Radius.circular(
                  10,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: AppColor.darkGrey,
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  AppString.verifyCode,
                  style: TextStyle(
                    color: AppColor.blackText,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        style: TextStyle(
                          color: AppColor.grey,
                        ),
                        text: 'Check your sms inbox we sent\n',
                      ),
                      const TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                          fontSize: 12,
                        ),
                        text: ' you at ',
                      ),
                      TextSpan(
                        text: "+91${controller.phoneNumberController.text}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.blue,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 40.0,
                    bottom: 40.0,
                  ),
                  child: PinPut(
                    autofocus: true,
                    fieldsCount: 6,
                    eachFieldWidth: 45,
                    eachFieldHeight: 45,
                    onSubmit: (v) async {
                      if (!isNullEmptyOrFalse(
                          box.read(ArgumentConstant.verificationId))) {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId:
                                    box.read(ArgumentConstant.verificationId),
                                smsCode: v))
                            .then((value) async {
                          final user = await FirebaseAuth.instance.currentUser!;
                          final idToken = await user.getIdToken();
                          final token = idToken;
                          if (!isNullEmptyOrFalse(token)) {
                            FocusScope.of(context).unfocus();
                            if (!isNullEmptyOrFalse(user.uid)) {
                              box.write(ArgumentConstant.mobileUid, user.uid);
                            }
                            if (!isNullEmptyOrFalse(user.phoneNumber)) {
                              box.write(ArgumentConstant.userMobileNumber,
                                  user.phoneNumber);
                            }
                            box.write(
                                ArgumentConstant.numberFirebaseToken, token);
                            controller.isMobileNumberVerified.value = true;

                            Get.find<SplashController>().callVerifyUserApi(
                              context: context,
                              firebaseToken: token!,
                              isFromMobile: true,
                            );

                            Get.back();
                          }
                          print(value);
                        }).catchError((e) {
                          print(e.toString());
                          Get.snackbar(
                              "Invalid OTP", "Please provide right OTP",
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              borderRadius: 0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.zero);
                        });
                      }
                    },
                    onChanged: (v) {
                      // setState(() {});
                    },
                    textStyle: TextStyle(
                        fontSize: MySize.getHeight(32),
                        fontWeight: FontWeight.w700),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.greyBackground,
                    ),
                    selectedFieldDecoration: _pinPutDecoration.copyWith(
                      color: AppColor.greyBackground,
                    ),
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.greyBackground,
                      // shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                const Text(
                  AppString.dontReceiveCode,
                  style: TextStyle(
                    color: AppColor.darkGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 40.0,
                  ),
                  child: Text(
                    AppString.resend,
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  height: 5,
                  width: 134,
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
                color: AppColor.blue, shape: BoxShape.circle),
            child: const Icon(
              Icons.check,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
