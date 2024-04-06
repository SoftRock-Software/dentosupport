import 'dart:io';

import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/bottom%20widget/get_bottom_for_addnew_patient.dart';
import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/get_patient_list_widget_home.dart';
import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/get_search_patient_list_widget.dart';
import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../global/constants/size_constant.dart';
import '../../../../main.dart';
import '../controllers/add_patient_and_home_screen_controller.dart';
import 'bottom widget/get_bottom_widget_home.dart';

class AddPatientAndHomeScreenView
    extends GetWidget<AddPatientAndHomeScreenController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return WillPopScope(
      onWillPop: () async {
        showConfirmationDialog(
          context: context,
          cancelText: "No",
          submitText: "Yes",
          cancelBackColor: AppColor.blue,
          submitBackColor: AppColor.blue,
          cancelTextColor: AppColor.white,
          submitTextColor: AppColor.white,
          submitCallBack: () {
            exit(0);
          },
          cancelCallback: () {
            Get.back();
          },
          contentWidget: Column(
            children: [
              Text(
                "You want to exit?",
                style: TextStyle(
                  fontSize: MySize.getHeight(17),
                ),
              ),
              Spacing.height(5),
              Text(
                "Are you sure?",
                style: TextStyle(
                  fontSize: MySize.getHeight(13),
                ),
              ),
            ],
          ),
        );

        /*showDialog(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: const Text('Are you sure you want to exit?'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.blue,
                  ),
                  // color: appTheme.primaryTheme,
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          },
        );*/
        return false;
      },
      child: Obx(() {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "dento",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "support",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    print(
                        "Clinic Id := ${box.read(ArgumentConstant.clinicId)}");
                    Get.toNamed(Routes.USER_SETTING_SCREEN);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: MySize.getWidth(15)),
                    child: CircleAvatar(
                      backgroundColor: AppColor.blue,
                      radius: MySize.getHeight(17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.userName.value.toString().toUpperCase(),
                            /*box
                                .read(ArgumentConstant.userLatterName)
                                .toString()
                                .toUpperCase(),*/
                            style: TextStyle(
                              fontSize: MySize.getHeight(12),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              /*actions: [
                InkWell(
                  onTap: () {
                    print(
                        "Clinic Id := ${box.read(ArgumentConstant.clinicId)}");
                    Get.toNamed(Routes.USER_SETTING_SCREEN);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    margin: EdgeInsets.only(
                      right: 25,
                    ),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        controller.userName.value.toString().toUpperCase(),
                        /*box
                            .read(ArgumentConstant.userLatterName)
                            .toString()
                            .toUpperCase(),*/
                        style: TextStyle(
                          fontSize: MySize.getHeight(10),
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
                */
            ),
            body: (controller.hasData.isFalse)
                ? Center(
                    child: CircularProgressIndicator(color: AppColor.blue),
                  )
                : Container(
                    child: Stack(
                      children: [
                        (controller.hasSearchData.isFalse)
                            ? Container(
                                height: MySize.screenHeight,
                                width: MySize.screenWidth,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: AppColor.blue,
                                ),
                              )
                            : (controller.isSearchStarted.isTrue)
                                ? SearchPatientListWidget(
                                    addPatientAndHomeScreenController:
                                        controller,
                                  )
                                : (controller.isPatientNotAdded.isTrue)
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(imageSvgPath +
                                                "add_patient_logo.svg"),
                                            SizedBox(
                                                height: MySize.getHeight(10)),
                                            Text(
                                              "Add Patients",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MySize.getHeight(18)),
                                            ),
                                            SizedBox(
                                                height: MySize.getHeight(10)),
                                            Text(
                                              "Use Search to add new patient",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      MySize.getHeight(16)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GetPatientListWidgetHomeScreen(
                                        addPatientAndHomeScreenController:
                                            controller),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 1),
                                blurRadius: MySize.getHeight(10),
                                spreadRadius: MySize.getHeight(2),
                              ),
                            ]),
                            child: Container(
                              child: Column(
                                children: [
                                  if (controller.isAddPatientActive.isTrue)
                                    HomeAddNewPatientBottom(
                                        addPatientAndHomeScreenController:
                                            controller)
                                  else
                                    HomeBottomWidget(
                                        addPatientAndHomeScreenController:
                                            controller),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
      }),
    );
  }
}
