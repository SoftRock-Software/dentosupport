import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/get_bottom_for_action.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/get_bottom_widget_add_new_procedure.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/get_bottom_widget_record_payment.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/active_trement_widget.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/completed_trement_widget.dart';
import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/get_bottom_add_treatment_individual_patient.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/get_bottom_widget_indivual_patient.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../main.dart';
import '../../add_patient_and_home_screen/views/bottom widget/get_bottom_for_addnew_patient.dart';
import '../controllers/individual_patient_screen_controller.dart';

class IndividualPatientScreenView
    extends GetWidget<IndividualPatientScreenController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(
            // top: 5.0,
            ),
        child: GestureDetector(
          onTap: () {
            controller.isActionBottomActive.value = false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              toolbarHeight: MySize.getHeight(80),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.blue,
                  size: MySize.getHeight(20),
                ),
              ),
              title: Column(
                children: [
                  Text(
                    controller.patientName,
                    style: TextStyle(
                      fontSize: MySize.getHeight(22),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Text(
                        controller.patientName,
                        style: TextStyle(
                          fontSize: MySize.getHeight(22),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),*/
                      Text(
                        "(${controller.patientAge},${controller.patientGender})",
                        style: TextStyle(
                          fontSize: MySize.getHeight(14),
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Spacing.height(5),
                  InkWell(
                    onTap: () {
                      print(box.read(ArgumentConstant.clinicId));
                      urlLauncher(number: controller.patientNumber.toString());
                    },
                    child: Text(
                      controller.patientNumber,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue),
                    ),
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    controller.closeAllBottoms();
                    controller.isActionBottomActive.value = true;
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: MySize.getWidth(10)),
                      child: Icon(Icons.more_vert, color: AppColor.blue)),
                ),
              ],
              centerTitle: true,
            ),
            body: Container(
              height: MySize.screenHeight,
              width: MySize.screenWidth,
              child: Stack(
                children: [
                  Container(
                    height: MySize.screenHeight,
                    width: MySize.screenWidth,
                    child: (controller.hasData.isFalse)
                        ? Center(
                            child:
                                CircularProgressIndicator(color: AppColor.blue),
                          )
                        : (isNullEmptyOrFalse(
                                    controller.completedTreatmentList) &&
                                isNullEmptyOrFalse(
                                    controller.activeTreatmentList))
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 79.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 188,
                                        height: 140,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          imagePngPath +
                                              "no_active_treatment.png",
                                          // "no_active_treatment_icon.png",
                                        ),
                                      ),
                                      Spacing.height(37),
                                      Text(
                                        "No Active Treatment",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MySize.getHeight(150)),
                                  child: Column(
                                    children: [
                                      if (!isNullEmptyOrFalse(
                                          controller.activeTreatmentList))
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MySize.getHeight(42)),
                                          child: ActiveTreatmentWidget(
                                              individualPatientScreenController:
                                                  controller),
                                        ),
                                      if (!isNullEmptyOrFalse(
                                          controller.completedTreatmentList))
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MySize.getHeight(20)),
                                          child: CompletedTreatmentWidget(
                                              individualPatientScreenController:
                                                  controller),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                  ),
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
                            if (controller.isAddTreatmentActive.isTrue)
                              BottomWidgetAddTreatment(
                                  individualPatientScreenController: controller)
                            else if (controller.isAddProcedureActive.isTrue)
                              BottomWidgetForAddNewProcedure(
                                  individualPatientScreenController: controller,
                                  treatmentId: controller.treatmentId.value)
                            else if (controller.isAddRecordPaymentActive.isTrue)
                              BottomWidgetForRecordPayment(
                                  individualPatientScreenController: controller)
                            else if (controller.isActionBottomActive.isTrue)
                              BottomWidgetForAction(
                                  individualPatientScreenController: controller)
                            else if (controller.isEditPatientActive.isTrue)
                              HomeAddNewPatientBottom(
                                  individualPatientScreenController: controller,
                                  isEdit: true)
                            else
                              BottomWidgetIndividualPatient(
                                  individualPatientScreenController:
                                      controller),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
