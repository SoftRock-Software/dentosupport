import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/controllers/add_patient_and_home_screen_controller.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../global/constants/api_constant.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/my_text_field.dart';
import '../../../../../global/utils/uitilities.dart';

class HomeBottomWidget extends StatefulWidget {
  AddPatientAndHomeScreenController addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();

  HomeBottomWidget({required this.addPatientAndHomeScreenController});

  @override
  HomeBottomWidgetState createState() => HomeBottomWidgetState();
}

class HomeBottomWidgetState extends State<HomeBottomWidget> {
  AddPatientAndHomeScreenController controller =
      AddPatientAndHomeScreenController();

  @override
  void initState() {
    controller = widget.addPatientAndHomeScreenController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: MySize.getHeight(132),
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(vertical: MySize.getHeight(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacing.height(8),
            Padding(
              padding: const EdgeInsets.only(
                right: 54.0,
                left: 20,
              ),
              child: Row(
                children: [
                  if (controller.isSearchStarted.isTrue)
                    InkWell(
                      onTap: () {
                        controller.searchController.value.clear();
                        controller.searchPatientsOnChange.value = "";
                        controller.isSearchStarted.value = false;
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.blue,
                        size: 20,
                      ),
                    )
                  else
                    Spacing.width(20),
                  Spacing.width(14),
                  Expanded(
                    child: Container(
                      height: MySize.getHeight(36),
                      // width: MySize.getWidth(268),
                      child: getTextField(
                        textEditingController:
                            controller.searchController.value,
                        // upperCaseTextFormatter: true,
                        lcPadding: 0,
                        tcPadding: 0,
                        rcPadding: 8,
                        bcPadding: 0,
                        // upperCaseTextFormatter: true,
                        onChange: (val) {
                          controller.searchPatientsOnChange.value = val;
                          // if (val.length > 3) {
                          if (!isNullEmptyOrFalse(val.trim())) {
                            controller.isSearchStarted.value = true;
                            controller.searchPatientApi(
                              context: context,
                              text: val,
                            );
                          } else {
                            controller.isSearchStarted.value = false;
                          }
                          // }
                          /*else {
                            if (!isNullEmptyOrFalse(val.trim())) {
                              controller.isSearchStarted.value = true;
                            } else {
                              controller.isSearchStarted.value = false;
                            }
                          }*/
                        },
                        hintText: "Search Patients",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: AppColor.grayDarkText.withOpacity(0.6),
                        ),
                        fillColor: Color(0xff767680).withOpacity(0.12),

                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            // left: 8,
                            top: 11,
                            bottom: 11,
                            // right: 6.37,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/svg/search_icon.svg",
                            height: 15,
                            width: 15,
                          ),
                        ),
                        /*Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 15.78,
                          ),*/

                        suffixIcon: controller
                                .searchPatientsOnChange.value.isEmpty
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  controller.searchController.value.clear();
                                  controller.searchPatientsOnChange.value = "";
                                  controller.isSearchStarted.value = false;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: MySize.getHeight(25),
                                  width: MySize.getHeight(25),
                                  child: SvgPicture.asset(
                                      imageSvgPath + "cancel_button_pic.svg",
                                      height: MySize.getHeight(25),
                                      width: MySize.getHeight(25)),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.getHeight(18)),
            InkWell(
              onTap: () {
                // debugPrint("-=-=-=-=${controller.searchController.value.text}");

                controller.nameController.value.clear();
                controller.addPatientNameOnChange.value = "";
                controller.mobileNumberController.value.clear();
                controller.addPatientPhoneNumberOnChange.value = "";
                controller.addSearchPatient.value = "";

                if (controller.searchController.value.text.trim().isNotEmpty) {
                  String? firstChar = controller.searchController.value.text
                      .trim()
                      .toString()[0];

                  if (RegExp(r"^[A-Za-z ]+$").hasMatch(firstChar)) {
                    controller.nameController.value.text =
                        controller.searchController.value.text.toString();
                    controller.addPatientNameOnChange.value =
                        controller.searchController.value.text.toString();
                    controller.addSearchPatient.value = "Name";
                    debugPrint("-=-=-=-If");
                  } else if (RegExp(r'^[0-9]+$').hasMatch(firstChar)) {
                    controller.mobileNumberController.value.text =
                        controller.searchController.value.text.toString();
                    controller.addPatientPhoneNumberOnChange.value =
                        controller.searchController.value.text.toString();
                    controller.addSearchPatient.value = "Number";
                    debugPrint("-=-=-=-else If");
                  } else {
                    controller.nameController.value.text =
                        controller.searchController.value.text.toString();
                    controller.addPatientNameOnChange.value =
                        controller.searchController.value.text.toString();
                    controller.addSearchPatient.value = "Name";
                    debugPrint("-=-=-=-Else");
                  }
                } else {
                  controller.nameController.value.text =
                      controller.searchController.value.text.toString();
                  controller.addPatientNameOnChange.value =
                      controller.searchController.value.text.toString();
                  debugPrint("-=-=-=-Else Else");
                }

                // String? value = controller.searchController.value.text;
                // controller.nameController.value.text = value;

                controller.isAddPatientActive.value = true;

                // SearchList Open
                controller.isSearchStarted.value = true;
              },
              child: getButton(
                  height: 43,
                  width: 162,
                  color: Colors.white,
                  borderRadius: 25,
                  fontSize: 14,
                  title: 'Add New Patient'),
            ),
            SizedBox(
              height: MySize.getHeight(15),
            ),
          ],
        ),
      ),
    );
  }
}
