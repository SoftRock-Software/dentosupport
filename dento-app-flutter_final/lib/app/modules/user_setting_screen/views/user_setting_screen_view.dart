import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../main.dart';
import '../../../../src/view/usersetting/component/user_settings_bottomView.dart';
import '../../../../src/view/usersetting/view/privacy_policy_screen.dart';
import '../../../../src/view/usersetting/view/tearms_condition_screen.dart';
import '../controllers/user_setting_screen_controller.dart';

class UserSettingScreenView extends GetWidget<UserSettingScreenController> {
  const UserSettingScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                // padding: EdgeInsets.only(
                //   top: 30,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 2),
                      color: Colors.black12,
                      spreadRadius: MySize.getHeight(2),
                      blurRadius: MySize.getHeight(10))
                ],
                color: AppColor.white,
              ),
              child: AppBar(
                elevation: 0,
                // toolbarHeight: MySize.getHeight(60),
                backgroundColor: AppColor.white,
                automaticallyImplyLeading: false,
                // toolbarHeight: 60,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: AppColor.blue),
                ),
                centerTitle: true,
                title: Text(
                  "User Settings",
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 16,
                  left: 32,
                  right: 32,
                  bottom: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      box.read(ArgumentConstant.userName),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    Text(
                      "(${box.read(ArgumentConstant.userEmail)})",
                      style: TextStyle(
                          color: AppColor.darkGreyText,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Switch to DentoSupport Pro",
                      style: TextStyle(
                          color: AppColor.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Coming Soon",
                      // "Only for 249/- per month",
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    commonRow("Edit Profile", () {
                      Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
                    }),
                    Divider(
                      color: AppColor.lightWhiteShade,
                      height: 0,
                    ),
                    // commonRow("Manage Clinics", () {}),
                    // Divider(
                    //   color: AppColor.lightWhiteShade,
                    // ),
                    commonRow("Notifications", () {}),
                    Divider(
                      color: AppColor.lightWhiteShade,
                      height: 0,
                    ),
                    commonRow("Terms & Conditions", () {
                      // Get.to(() => TearmsAndConditionScreen());
                      launch(
                        "https://www.dentosupport.com/Terms-of-use",
                      );
                    }),
                    Divider(
                      color: AppColor.lightWhiteShade,
                      height: 0,
                    ),
                    commonRow("Privacy Policy", () {
                      launch(
                        "https://www.dentosupport.com/privacy-policy",
                      );
                      // Get.to(() => PrivacyPolicyScreen());
                    }),
                    Divider(
                      color: AppColor.lightWhiteShade,
                      height: 0,
                    ),
                    // commonRow("Payment & Subscription", () {
                    //   Get.to(() => PaymentSubscriptionScreen());
                    // }),
                    SizedBox(
                      height: 44,
                    ),
                    /*Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 3,
                        bottom: 3.49,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        AppAsset.whatsappSvg,
                      ),
                      // child: Image.asset(AppAsset.whatsapp),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Have something to say, ask or suggest?\n Feel free to talk to our founders. :)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: UserSettingBottomView(),
    );
  }

  commonRow(String title, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MySize.getHeight(20)),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColor.darkBlackText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
