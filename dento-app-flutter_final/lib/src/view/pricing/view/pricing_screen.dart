import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/widgets/app_button.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:Dentosupport_mini/src/view/pricing/controller/pricng_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PricingScreen extends GetWidget<PricingController> {
  const PricingScreen({Key? key}) : super(key: key);

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                64,
              ),
              child: Image.asset(
                AppAsset.profileImage,
                height: 40,
                width: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    AppString.apurvaSonavane,
                    style: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AppString.apurvaSonavaneGmailCom,
                    style: TextStyle(
                      color: AppColor.textGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
            ),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.clear_rounded,
                color: AppColor.shadowGrey,
                size: 24,
              ),
            ),
          ),
        ],
        // elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 32.0,
                top: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.welcomeTo,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                bottom: 32.0,
              ),
              child: Row(
                children: const [
                  Text(
                    AppString.dento,
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppString.support,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              AppAsset.noMoreLostPayment,
              height: 140,
              width: 188,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 45.0,
                bottom: 7.0,
              ),
              child: Text(
                AppString.noMoreLostPayment,
                style: TextStyle(
                  color: AppColor.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 46.0,
                right: 46,
                bottom: 24,
              ),
              child: Text(
                AppString.weKeepTrackOfPayment,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Obx(
              () => controller.pricingPlan.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.pricingPlan.length,
                      itemBuilder: (
                        builder,
                        index,
                      ) {
                        return Obx(
                          () => planView(index),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32.0,
                    top: 16.0,
                  ),
                  child: AppButton(
                    onPressed: () {
                      Get.toNamed(
                        Routes.SIGNUP_SCREEN,
                      );
                    },
                    text: AppString.continueText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector planView(
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        index == 0 ? null : controller.selectPlan.value = index;
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 20,
        ),
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 11,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: index == 0 ? AppColor.grayBackground : AppColor.transparent,
          border: Border.all(
            color: controller.selectPlan.value == index
                ? AppColor.blue
                : AppColor.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              controller.selectPlan.value == index
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: controller.selectPlan.value == index
                  ? AppColor.blue
                  : AppColor.textGreyLight,
              size: 24,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.pricingPlan[index]["title"],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: index == 0
                              ? AppColor.darkGreyText
                              : AppColor.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          decoration: index == 0
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                      ),
                      child: Text(
                        index == 0
                            ? AppString.freeTrialExpired
                            : controller.pricingPlan[index]["description"],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: AppColor.textGreyLight,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
