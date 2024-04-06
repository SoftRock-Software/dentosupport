import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:Dentosupport_mini/src/view/home/component/add_patient.dart';
import 'package:Dentosupport_mini/src/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenBottom extends GetWidget<SignUpController> {
  HomeScreenBottom({Key? key}) : super(key: key);

  HomeController homeController = Get.put(
    HomeController(),
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            padding: const EdgeInsets.only(
              top: 80,
            ),
            decoration: const BoxDecoration(
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
            child: Row(
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
            ),
          ),
          InkWell(
            onTap: () {
              homeController.isActiveName.value = false;
              homeController.isActiveAge.value = false;
              homeController.isActivePhoneNo.value = false;
              homeController.isGenderSelect.value = "Male";
              Get.bottomSheet(
                const AddPatientView(),
              );
            },
            child: Container(
              // height: 55,
              // width: 55,
              padding: const EdgeInsets.only(
                left: 25,
                top: 15,
                bottom: 15,
                right: 43,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    100,
                  ),
                ),
                color: AppColor.blue,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAsset.addPatient,
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    AppString.addPatient,
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "4 Missed",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.red),
                    ),
                    Text(
                      "9 Visited",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Cash",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      "4,000",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue),
                    ),
                    Text(
                      "13,950",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
