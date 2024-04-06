import 'package:Dentosupport_mini/app/modules/individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/size_constant.dart';

class TreatmentCompletedListWidget extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();
  int index = 0;

  TreatmentCompletedListWidget(
      {required this.individualPatientScreenController, required this.index});

  @override
  _TreatmentCompletedListWidgetState createState() =>
      _TreatmentCompletedListWidgetState();
}

class _TreatmentCompletedListWidgetState
    extends State<TreatmentCompletedListWidget> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();
  int index = 0;

  @override
  void initState() {
    controller = widget.individualPatientScreenController;
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.only(top: MySize.getHeight(15)),
        child: Column(
          children: [
            if (controller.completedTreatmentList[index].isExpanded!.isFalse)
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.completedTreatmentList.forEach((element) {
                          if (element.id ==
                              controller.completedTreatmentList[index].id) {
                            controller.completedTreatmentList[index].isExpanded!
                                .toggle();
                          } else {
                            element.isExpanded!.value = false;
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MySize.getHeight(15),
                          left: 20,
                          right: 12,
                        ),
                        child: Row(
                          children: [
                            Spacing.width(15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                            .completedTreatmentList[index].name
                                            .toString() +
                                        (controller
                                                    .completedTreatmentList[
                                                        index]
                                                    .toothNumber ==
                                                null
                                            ? ""
                                            : controller
                                                        .completedTreatmentList[
                                                            index]
                                                        .toothNumber
                                                        .toString() ==
                                                    "[" "]"
                                                ? ""
                                                : " - ${controller.completedTreatmentList[index].toothNumber!.toList().join(", ").toString()}"),
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: MySize.getHeight(16),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacing.height(3),
                                  Text(
                                    controller.completedTreatmentList[index]
                                                .procedures
                                                .toString() ==
                                            "[]"
                                        ? "Last Procedure - ${DateFormat("dd/MM/yy").format(DateTime.parse(controller.completedTreatmentList[index].updatedAt!).toLocal())}"
                                        : "Last Procedure - ${DateFormat("dd/MM/yy").format(controller.completedTreatmentList[index].procedures!.last.dateTimeCreatedAt!.toLocal())}",
                                    style: TextStyle(
                                        fontSize: MySize.getHeight(12),
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff575757)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                name: "INR",
                                locale: 'en_IN',
                                customPattern: "##,##,###",
                                decimalDigits: 2,
                                // change it to get decimal places
                                symbol: '₹ ',
                              ).format(double.parse((controller
                                      .completedTreatmentList[index].amount!)
                                  .toString()
                                  .trim())),
                              style: TextStyle(
                                  fontSize: MySize.getHeight(14),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Spacing.width(5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: MySize.getHeight(13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index != controller.completedTreatmentList.length - 1)
                      SizedBox(
                        height: 0,
                        child: Divider(),
                      ),
                  ],
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(
                            MySize.getHeight(3),
                            MySize.getHeight(3),
                          ),
                          blurRadius: MySize.getHeight(1),
                          spreadRadius: MySize.getHeight(1)),
                    ],
                    borderRadius: BorderRadius.circular(MySize.getHeight(10))),
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                padding: EdgeInsets.symmetric(
                    vertical: MySize.getHeight(6),
                    horizontal: MySize.getWidth(14)),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.completedTreatmentList.forEach((element) {
                          if (element.id ==
                              controller.completedTreatmentList[index].id) {
                            controller.completedTreatmentList[index].isExpanded!
                                .toggle();
                          } else {
                            element.isExpanded!.value = false;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.completedTreatmentList[index].name
                                          .toString() +
                                      (controller.completedTreatmentList[index]
                                                  .toothNumber ==
                                              null
                                          ? ""
                                          : controller
                                                      .completedTreatmentList[
                                                          index]
                                                      .toothNumber
                                                      .toString() ==
                                                  "[" "]"
                                              ? ""
                                              : " - ${controller.completedTreatmentList[index].toothNumber!.toList().join(", ").toString()}"),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColor.blue,
                                      fontSize: MySize.getHeight(16),
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacing.height(3),
                                Text(
                                  (!isNullEmptyOrFalse(controller
                                          .completedTreatmentList[index]
                                          .procedures))
                                      ? controller.completedTreatmentList[index]
                                          .procedures!.first.name
                                          .toString()
                                      : controller
                                          .completedTreatmentList[index].name
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: MySize.getHeight(12),
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575757)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              name: "INR",
                              locale: 'en_IN',
                              customPattern: "##,##,###",
                              decimalDigits: 2,
                              // change it to get decimal places
                              symbol: '₹ ',
                            ).format(double.parse((controller
                                    .completedTreatmentList[index]
                                    .amount! /**
                                -1*/
                                )
                                .toString()
                                .trim())),
                            style: TextStyle(
                                fontSize: MySize.getHeight(14),
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Spacing.width(5),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: MySize.getHeight(20),
                          ),
                        ],
                      ),
                    ),
                    if (!isNullEmptyOrFalse(
                        controller.completedTreatmentList[index].procedures))
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: MySize.getHeight(10)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MySize.getHeight(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: List.generate(
                                      controller.completedTreatmentList[index]
                                          .procedures!.length, (ind) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: MySize.getHeight(24),
                                              width: MySize.getWidth(24),
                                              decoration: BoxDecoration(
                                                  color: AppColor.blue,
                                                  shape: BoxShape.circle),
                                              child: Text(
                                                (ind + 1).toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MySize.getWidth(16),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MySize.getWidth(200),
                                                  child: Text(
                                                    controller
                                                        .completedTreatmentList[
                                                            index]
                                                        .procedures![ind]
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            MySize.getHeight(
                                                                14),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat("dd-MM-yyyy")
                                                      .format(controller
                                                          .completedTreatmentList[
                                                              index]
                                                          .procedures![ind]
                                                          .dateTimeCreatedAt!),
                                                  style: TextStyle(
                                                      color: Color(0xff555555),
                                                      fontSize:
                                                          MySize.getHeight(12),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        if (ind !=
                                            controller
                                                    .completedTreatmentList[
                                                        index]
                                                    .procedures!
                                                    .length -
                                                1)
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: MySize.getWidth(11),
                                              top: MySize.getWidth(4),
                                              bottom: MySize.getWidth(4),
                                            ),
                                            height: MySize.getHeight(30),
                                            width: MySize.getWidth(1),
                                            color: Colors.black,
                                          ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
