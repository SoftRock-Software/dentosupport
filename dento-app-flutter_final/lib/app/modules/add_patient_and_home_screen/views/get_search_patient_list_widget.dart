import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/widgets/custom_dialogs.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../main.dart';
import '../controllers/add_patient_and_home_screen_controller.dart';

class SearchPatientListWidget extends StatefulWidget {
  AddPatientAndHomeScreenController addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();

  SearchPatientListWidget({required this.addPatientAndHomeScreenController});

  @override
  _SearchPatientListWidgetState createState() =>
      _SearchPatientListWidgetState();
}

class _SearchPatientListWidgetState extends State<SearchPatientListWidget> {
  AddPatientAndHomeScreenController controller =
      AddPatientAndHomeScreenController();

  @override
  void initState() {
    controller = widget.addPatientAndHomeScreenController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySize.screenHeight,
      width: MySize.screenWidth,
      child: (isNullEmptyOrFalse(controller.searchPatientList))
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 79.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 51,
                      ),
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        imagePngPath + "no_new_patients_found.png",
                        // "no_active_treatment_icon.png",
                      ),
                    ),
                    Spacing.height(27),
                    Text(
                      "No result found",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          /*Center(
              child: Text(
                "No result found",
                style: TextStyle(
                  fontSize: MySize.getHeight(20),
                  fontWeight: FontWeight.w400,
                ),
              ),
            )*/
          : ListView.separated(
              padding: EdgeInsets.only(
                top: MySize.getHeight(20),
                left: MySize.getWidth(20),
                right: MySize.getWidth(20),
                bottom: MySize.getHeight(200),
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();

                    FocusManager.instance.primaryFocus!.unfocus();
                    Get.toNamed(Routes.INDIVIDUAL_PATIENT_SCREEN, arguments: {
                      ArgumentConstant.patientId:
                          controller.searchPatientList[index].id.toString(),
                      ArgumentConstant.patientName:
                          controller.searchPatientList[index].name.toString(),
                      ArgumentConstant.lastVisitedDate: controller
                          .searchPatientList[index].lastVisitedDate
                          .toString(),
                      ArgumentConstant.patientAge:
                          controller.searchPatientList[index].age.toString(),
                      ArgumentConstant.patientGender:
                          controller.searchPatientList[index].gender.toString(),
                      ArgumentConstant.patientNumber:
                          controller.searchPatientList[index].mobile.toString(),
                    });

                    controller.searchController.value.clear();
                    controller.searchPatientsOnChange.value =
                    "";
                    controller.isSearchStarted.value = false;
                    // FocusScope.of(context).unfocus();

                    /*controller.callAddVisitorApi(
                      context: context,
                      patientId: controller.searchPatientList[index].id!,
                      justAdd: true,
                    );*/
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.searchPatientList[index].name.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MySize.getHeight(17)),
                        ),
                        Text(
                          /*(!isNullEmptyOrFalse(controller
                                  .searchPatientList[index].treatments))
                              ? (!isNullEmptyOrFalse(controller
                                      .searchPatientList[index]
                                      .treatments![0]
                                      .procedures))
                                  ? controller.searchPatientList[index]
                                      .treatments![0].procedures![0].name
                                      .toString()
                                  : controller.searchPatientList[index]
                                      .treatments![0].name
                                      .toString()
                              : "",*/
                          (!isNullEmptyOrFalse(
                                  controller.searchPatientList[index].mobile))
                              ? controller.searchPatientList[index].mobile
                                  .toString()
                              : "",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: MySize.getHeight(15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: MySize.getHeight(20),
                );
              },
              itemCount: controller.searchPatientList.length),
    );
  }
}
