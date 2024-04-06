import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/splash_controller.dart';

Widget splashView(context, {required SplashController controller}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePngPath + "splash_screen.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Spacing.height(200),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  "Managing Your Clinic Made Easy",
                  style: TextStyle(
                    height: 1.3,
                    color: AppColor.black,
                    fontSize: MySize.getHeight(22),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  // GoogleSignIn signIn = GoogleSignIn();
                  // signIn.signOut();
                  clearBox();
                  controller.signInWithGoogle(context: context);
                },
                child: Container(
                  padding: EdgeInsets.all(
                    19,
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppAsset.google,
                        height: 22,
                        width: 22,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                      Container(
                        color: AppColor.transparent,
                        height: 22,
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => Get.toNamed(Routes.PHONE_LOGIN_SCREEN),
                child: Container(
                  padding: EdgeInsets.all(
                    14,
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppString.loginWithPhoneNumber,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                          Text(
                            "(Sign up required)",
                            style: TextStyle(
                              fontSize: 10,
                              // fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // InkWell(
              //   onTap: () {
              //
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(
              //       19,
              //     ),
              //     margin: const EdgeInsets.only(
              //       left: 20,
              //       right: 20,
              //       top: 8,
              //       bottom: 27,
              //     ),
              //     decoration: BoxDecoration(
              //       color: AppColor.blue,
              //       borderRadius: BorderRadius.circular(
              //         10,
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: const [
              //         Text(
              //           AppString.loginWithPhoneNumber,
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600,
              //             color: AppColor.white,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    ],
  );
}
