import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/src/view/editprofile/view/edit_profile_screen.dart';
import 'package:Dentosupport_mini/src/view/home/component/add_patient.dart';
import 'package:Dentosupport_mini/src/view/home/component/home_screen_bottom.dart';
import 'package:Dentosupport_mini/src/view/home/view/home_screen.dart';
import 'package:Dentosupport_mini/src/view/patientview/view/patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_color.dart';
import '../../editclinics/view/edit_clinic_screen.dart';
import '../../usersetting/view/user_setting_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                onTap: () {
                  // Get.to(() => const UserSettingScreen());
                },
                // controller: controller.otp,
                // textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  color: AppColor.blackText,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      left: 24,
                      top: 0,
                      right: 0,
                      bottom: 0,
                    ),
                    fillColor: AppColor.white,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.red,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.whiteBackground,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.whiteBackground,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    hintText: "Type o Search",
                    hintStyle: const TextStyle(
                      color: AppColor.lightGreyText,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      onPressed: () {
                        Get.to(() => HomeScreen());
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColor.blue,
                      ),
                    ),
                    suffixIcon: Image.asset(AppAsset.searchClose)),
              ),
              // searchView(),
              searchEmptyView()
            ],
          ),
        ),
      ),
    );
  }

  searchEmptyView() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 14),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                Get.to(() => UserSettingScreen());
              },
              child: Image.asset(AppAsset.searchLoading)),
          SizedBox(
            height: 37,
          ),
          Text(
            "Get Started with Search",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Search with Patient name, Phone number or treatment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.navyGreyDarkBackground),
            ),
          )
        ],
      ),
    ));
  }

  searchView() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 14),
            padding: EdgeInsets.symmetric(vertical: 19, horizontal: 21),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
                borderRadius: BorderRadius.circular(15)),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Apurva Sonavane",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "9876541231",
                              style: TextStyle(
                                  color: AppColor.greyText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "Check-in",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blue),
                        )
                      ],
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 40,
                );
              },
            )),
        Row(
          children: [
            Spacer(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 17),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1, 1))
              ], color: AppColor.blue, borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  Get.to(() => HomeScreen());
                  Get.bottomSheet(const AddPatientView());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add New Patient",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        )
      ],
    );
  }
}
