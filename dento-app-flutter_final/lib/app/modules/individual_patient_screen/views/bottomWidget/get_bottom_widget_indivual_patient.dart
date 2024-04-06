import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../global/constants/app_color.dart';
import '../../controllers/individual_patient_screen_controller.dart';

class BottomWidgetIndividualPatient extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();

  BottomWidgetIndividualPatient(
      {required this.individualPatientScreenController});

  @override
  _BottomWidgetIndividualPatientState createState() =>
      _BottomWidgetIndividualPatientState();
}

class _BottomWidgetIndividualPatientState
    extends State<BottomWidgetIndividualPatient> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();

  @override
  void initState() {
    controller = widget.individualPatientScreenController;
    super.initState();
  }

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MySize.getHeight(132),
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isNullEmptyOrFalse(controller.completedTreatmentList) &&
                  isNullEmptyOrFalse(controller.activeTreatmentList))
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 17.0,
                  ),
                  child: Text(
                    "No Pending Payment",
                    style: TextStyle(
                        fontSize: MySize.getHeight(14),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black),
                  ),
                )
              // ? Spacing.height(17)
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 17.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.pendingPayment.value == "0.0"
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 17.0,
                              ),
                              child: Text(
                                "No Pending Payment",
                                style: TextStyle(
                                    fontSize: MySize.getHeight(14),
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black),
                              ),
                            )
                          : Text(
                              "Pending Payment : ",
                              style: TextStyle(
                                  fontSize: MySize.getHeight(14),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black),
                            ),
                      controller.pendingPayment.value == "0.0"
                          ? SizedBox()
                          : Text(
                              NumberFormat.currency(
                                name: "INR",
                                locale: 'en_IN',
                                customPattern: "##,##,###",
                                decimalDigits: 2,
                                // change it to get decimal places
                                symbol: '₹ ',
                              )
                                  .format(double.parse(controller
                                      .pendingPayment.value
                                      .toString()))
                                  .toString(),
                              style: TextStyle(
                                  fontSize: MySize.getHeight(14),
                                  fontWeight: FontWeight.w700),
                            ),
                    ],
                  ),
                ),
          controller.lastVisitedDate == "" ||
                  controller.lastVisitedDate == "null"
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "New Patient",
                    // "Last Visited ${controller.lastVisitedDate.toString()}",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: MySize.getHeight(11),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              // ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Last Visited ${DateFormat('dd MMM, yy').format(DateTime.parse(controller.lastVisitedDate.toString()))}",
                    // "Last Visited ${controller.lastVisitedDate.toString()}",
                    style: TextStyle(
                      color: AppColor.grayLightText,
                      fontSize: MySize.getHeight(11),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
          Spacing.height(17),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.toothNumberList.clear();
                  controller.isAddTreatmentActive.value = true;
                },
                child: getButton(
                    title: "Add Treatment",
                    height: 43,
                    width: 162,
                    fontSize: 15,
                    borderRadius: 20),
              ),
              (isNullEmptyOrFalse(controller.completedTreatmentList) &&
                      isNullEmptyOrFalse(controller.activeTreatmentList))
                  ? SizedBox()
                  : Spacing.width(15),
              (isNullEmptyOrFalse(controller.completedTreatmentList) &&
                      isNullEmptyOrFalse(controller.activeTreatmentList))
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        // controller.callGetTreatmentListApi(
                        //     context: context, patientId: controller.patientId);
                        controller.isAddRecordPaymentActive.value = true;
                        /*controller.paymentAmount.value.text =
                            controller.pendingPayment.value.toString();*/
                      },
                      child: getButton(
                        title: "Record Payment",
                        height: 43,
                        width: 162,
                        fontSize: 15,
                        borderRadius: 20,
                      ),
                    ),
            ],
          ),
          Spacing.height(17),
        ],
      ),
    );
  }
}
