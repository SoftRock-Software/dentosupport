import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:Dentosupport_mini/src/view/editprofile/view/edit_profile_screen.dart';
import 'package:Dentosupport_mini/src/view/home/component/add_patient.dart';
import 'package:Dentosupport_mini/src/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSettingBottomView extends GetWidget<SignUpController> {
  UserSettingBottomView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'helpdesk@dentosupport.com',
                query: encodeQueryParameters(<String, String>{'subject': ''}),
              );

              launchUrl(emailLaunchUri);
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 3,
                bottom: 3.49,
              ),
              margin: EdgeInsets.only(
                top: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.email_outlined,
                color: AppColor.blue,
              ),
              /*child: SvgPicture.asset(
                AppAsset.whatsappSvg,
              ),*/
              // child: Image.asset(AppAsset.whatsapp),
            ),
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
          ),
          SizedBox(
            height: 16,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                padding: const EdgeInsets.only(
                  top: 80,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(10, 0))
                  ],
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      25,
                    ),
                    topRight: Radius.circular(
                      25,
                    ),
                  ),
                ),
                /* child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                ),*/
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      getLogOut();
                    },
                    child: Container(
                      // height: 55,
                      // width: 55,
                      padding: const EdgeInsets.only(
                        left: 50,
                        top: 15,
                        bottom: 15,
                        right: 50,
                      ),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            100,
                          ),
                        ),
                        color: AppColor.red,
                      ),
                      child: const Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "At your service,",
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w700),
                  //     ),
                  //     Text(
                  //       "At your service,",
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w700),
                  //     ),
                  //   ],
                  // )
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w600),
                      text: 'At your service,',
                    ),
                    TextSpan(
                      style: TextStyle(
                          color: AppColor.blue, fontWeight: FontWeight.w700),
                      text: ' dento',
                    ),
                    TextSpan(
                      style: TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w700),
                      text: 'support',
                    ),
                    TextSpan(
                      style: TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w600),
                      text: ' team.',
                    )
                  ]))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
