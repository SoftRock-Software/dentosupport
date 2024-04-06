import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/src/view/editprofile/view/edit_profile_screen.dart';
import 'package:Dentosupport_mini/src/view/usersetting/view/privacy_policy_screen.dart';
import 'package:Dentosupport_mini/src/view/usersetting/view/tearms_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_string.dart';
import '../../../../main.dart';
import '../../home/component/home_screen_bottom.dart';
import '../../paymentsubscription/view/payment_subscription_screen.dart';
import '../component/user_settings_bottomView.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({Key? key}) : super(key: key);

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.whiteBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColor.blue),
        ),
        centerTitle: true,
        title: Text(
          "User Settings",
          style: TextStyle(color: AppColor.blue),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10, left: 32, right: 32, bottom: 30),
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
                  height: 33,
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
                // Container(
                //   alignment: Alignment.center,
                //   height: 26,
                //   width: 61,
                //   decoration: BoxDecoration(
                //       color: AppColor.blue,
                //       borderRadius: BorderRadius.circular(20)),
                //   child: Text(
                //     "Renew",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 11,
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),
                Text(
                  "Only for 249/- per month",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 60,
                ),
                commonRow("Edit Profile", () {
                  Get.to(() => EditProfileScreen());
                }),
                Divider(
                  color: AppColor.lightWhiteShade,
                ),
                // commonRow("Manage Clinics", () {}),
                // Divider(
                //   color: AppColor.lightWhiteShade,
                // ),
                commonRow("Notifications", () {}),
                Divider(
                  color: AppColor.lightWhiteShade,
                ),
                commonRow("Terms & Conditions", () {
                  Get.to(() => TearmsAndConditionScreen());
                }),
                Divider(
                  color: AppColor.lightWhiteShade,
                ),
                commonRow("Privacy Policy", () {
                  Get.to(() => PrivacyPolicyScreen());
                }),
                Divider(
                  color: AppColor.lightWhiteShade,
                ),
                // commonRow("Payment & Subscription", () {
                //   Get.to(() => PaymentSubscriptionScreen());
                // }),
                SizedBox(
                  height: 44,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 31,
                  width: 31,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(AppAsset.whatsapp),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Have something to say, ask or suggest?\n Feel free to talk to our founders. :)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColor.darkBlackText,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
