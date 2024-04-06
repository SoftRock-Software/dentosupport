import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/widgets/text_field.dart';
import 'package:Dentosupport_mini/src/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPatientView extends GetWidget<HomeController> {
  const AddPatientView({Key? key}) : super(key: key);

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
              top: 30,
            ),
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
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        AppString.patientInformation,
                        style: TextStyle(
                          color: AppColor.blackText,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: commonTextField(
                            hintText: AppString.phoneNo,
                            controller: controller.phoneNo,
                            hintTextBold: true,
                            titleTextBold: true,
                            needValidation: true,
                            isActive: controller.isActivePhoneNo.value,
                            hintTextColor: AppColor.darkGreyText,
                            labelTextColor: AppColor.darkGreyText,
                            onPressed: () {
                              controller.isActiveName.value = false;
                              controller.isActiveAge.value = false;
                              controller.isActivePhoneNo.value = true;
                            },
                            validationMessage: "Phone No",
                            labelText: AppString.phoneNo,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 3,
                          child: commonTextField(
                            hintText: AppString.name,
                            controller: controller.name,
                            hintTextBold: true,
                            titleTextBold: true,
                            needValidation: true,
                            isActive: controller.isActiveName.value,
                            hintTextColor: AppColor.darkGreyText,
                            labelTextColor: AppColor.darkGreyText,
                            onPressed: () {
                              controller.isActiveName.value = true;
                              controller.isActiveAge.value = false;
                              controller.isActivePhoneNo.value = false;
                            },
                            validationMessage: "Name",
                            labelText: AppString.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 7,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteBackground,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: genderView(
                                          gender: "Male",
                                          genderCode: "M",
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width: 1,
                                        color: AppColor.greyLight,
                                      ),
                                      Expanded(
                                        child: genderView(
                                          gender: "Female",
                                          genderCode: "F",
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width: 1,
                                        color: AppColor.greyLight,
                                      ),
                                      Expanded(
                                        child: genderView(
                                          gender: "Other",
                                          genderCode: "O",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 1, left: 6, right: 3),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: const Text(
                                  "Gender",
                                  style: TextStyle(
                                    color: AppColor.darkGreyText,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 3,
                          child: commonTextField(
                            hintText: AppString.age,
                            controller: controller.age,
                            hintTextBold: true,
                            titleTextBold: true,
                            needValidation: true,
                            hintTextColor: AppColor.darkGreyText,
                            labelTextColor: AppColor.darkGreyText,
                            isActive: controller.isActiveAge.value,
                            onPressed: () {
                              controller.isActiveName.value = false;
                              controller.isActivePhoneNo.value = false;
                              controller.isActiveAge.value = true;
                            },
                            validationMessage: "Age",
                            labelText: AppString.age,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: AppColor.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  genderView({
    String? gender,
    String? genderCode,
  }) {
    return GestureDetector(
      onTap: () {
        controller.isGenderSelect.value = "$gender";
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 12.83,
          right: 12.83,
          top: 8,
          bottom: 8,
        ),
        margin: const EdgeInsets.only(
          top: 12,
          bottom: 7,
          left: 4,
          right: 4,
        ),
        decoration: BoxDecoration(
          color: controller.isGenderSelect.value == "$gender"
              ? AppColor.white
              : AppColor.transparent,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Text(
          "$genderCode",
          style: const TextStyle(
            color: AppColor.blackDark,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
