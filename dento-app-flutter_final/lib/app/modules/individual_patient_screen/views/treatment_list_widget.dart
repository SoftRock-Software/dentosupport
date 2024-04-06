import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/size_constant.dart';
import '../controllers/individual_patient_screen_controller.dart';

class TreatmentListWidget extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();
  int index = 0;

  TreatmentListWidget(
      {required this.individualPatientScreenController, required this.index});

  @override
  State<TreatmentListWidget> createState() => _TreatmentListWidgetState();
}

class _TreatmentListWidgetState extends State<TreatmentListWidget> {
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
        padding: EdgeInsets.only(top: MySize.getHeight(13)),
        child: Column(
          children: [
            if (controller.activeTreatmentList[index].isExpanded!.isFalse)
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.activeTreatmentList.forEach((element) {
                          if (element.id ==
                              controller.activeTreatmentList[index].id) {
                            controller.activeTreatmentList[index].isExpanded!
                                .toggle();
                          } else {
                            element.isExpanded!.value = false;
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MySize.getHeight(7),
                          left: 12,
                          right: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MySize.getHeight(10),
                              width: MySize.getWidth(10),
                              margin: EdgeInsets.only(top: MySize.getHeight(5)),
                              decoration: BoxDecoration(
                                  color: AppColor.blue, shape: BoxShape.circle),
                            ),
                            Spacing.width(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.activeTreatmentList[index].name
                                            .toString() +
                                        (controller.activeTreatmentList[index]
                                                    .toothNumber ==
                                                null
                                            ? ""
                                            : controller
                                                        .activeTreatmentList[
                                                            index]
                                                        .toothNumber ==
                                                    []
                                                ? ""
                                                : controller
                                                        .activeTreatmentList[
                                                            index]
                                                        .toothNumber!
                                                        .isEmpty
                                                    ? ""
                                                    : controller
                                                                .activeTreatmentList[
                                                                    index]
                                                                .toothNumber
                                                                .toString() ==
                                                            "[" "]"
                                                        ? ""
                                                        : " - ${controller.activeTreatmentList[index].toothNumber!.join(", ").toString()}"),
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: MySize.getHeight(16),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacing.height(3),
                                  Text(
                                    (!isNullEmptyOrFalse(controller
                                            .activeTreatmentList[index]
                                            .procedures))
                                        ? controller.activeTreatmentList[index]
                                            .procedures!.last.name
                                            .toString()
                                        : controller
                                            .activeTreatmentList[index].name
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
                                      .activeTreatmentList[index].amount!)
                                  // * -1)
                                  .toString()
                                  .trim())),
                              style: TextStyle(
                                  fontSize: MySize.getHeight(14),
                                  fontWeight: FontWeight.w600,
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
                    /*if (index != controller.activeTreatmentList.length - 1)
                      SizedBox(
                        height: 0,
                        child: Divider(),
                      ),*/
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
                padding: EdgeInsets.symmetric(
                    vertical: MySize.getHeight(6),
                    horizontal: MySize.getWidth(14)),
                margin: EdgeInsets.only(
                  bottom: 13,
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.activeTreatmentList.forEach(
                          (element) {
                            if (element.id ==
                                controller.activeTreatmentList[index].id) {
                              controller.activeTreatmentList[index].isExpanded!
                                  .toggle();
                            } else {
                              element.isExpanded!.value = false;
                            }
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        controller
                                                .activeTreatmentList[index].name
                                                .toString() +
                                            (controller
                                                        .activeTreatmentList[
                                                            index]
                                                        .toothNumber ==
                                                    null
                                                ? ""
                                                : controller
                                                            .activeTreatmentList[
                                                                index]
                                                            .toothNumber ==
                                                        []
                                                    ? ""
                                                    : controller
                                                            .activeTreatmentList[
                                                                index]
                                                            .toothNumber!
                                                            .isEmpty
                                                        ? ""
                                                        : controller
                                                                    .activeTreatmentList[
                                                                        index]
                                                                    .toothNumber
                                                                    .toString() ==
                                                                "[" "]"
                                                            ? ""
                                                            : " - ${controller.activeTreatmentList[index].toothNumber!.join(", ").toString()}"),
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColor.blue,
                                            fontSize: MySize.getHeight(16),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Spacing.width(3),
                                    InkWell(
                                      onTap: () {
                                        controller.closeAllBottoms();
                                        controller.treatmentId.value =
                                            controller
                                                .activeTreatmentList[index].id
                                                .toString();
                                        controller.treatmentName.value.text =
                                            controller
                                                .activeTreatmentList[index].name
                                                .toString();
                                        controller
                                                .treatmentNameEditValue.value =
                                            controller
                                                .activeTreatmentList[index].name
                                                .toString();
                                        controller.treatmentAmount.value.text =
                                            controller
                                                .activeTreatmentList[index]
                                                .amount
                                                .toString();

                                        bool? isLeftSideView;
                                        int? toothNumberSelectTab;
                                        controller.toothNumberList.clear();

                                        debugPrint(
                                            "-=-=abc-=-=${controller.activeTreatmentList[index].toothNumber}");

                                        if (controller
                                                    .activeTreatmentList[index]
                                                    .toothNumber !=
                                                null ||
                                            controller
                                                    .activeTreatmentList[index]
                                                    .toothNumber
                                                    .toString() !=
                                                "[]" ||
                                            controller
                                                    .activeTreatmentList[index]
                                                    .toothNumber
                                                    .toString() !=
                                                "[0]") {
                                          controller.activeTreatmentList[index]
                                              .toothNumber!
                                              .forEach(
                                            (element) {
                                              debugPrint(
                                                  "-=-=element-=--$element");

                                              String? elementString;

                                              elementString =
                                                  element.toString().trim();

                                              debugPrint(
                                                  "-=-=elementString-=--$elementString");

                                              /*  debugPrint(
                                                  "-=-=elementString-0=--${elementString[0]}");

                                              debugPrint(
                                                  "-=-=elementString-1=--${elementString[1]}");*/

                                              // Find number to position

                                              if (elementString.isNotEmpty) {
                                                if (elementString[0] == "2") {
                                                  debugPrint(
                                                      "-=-=elementString[]-2=--");
                                                  isLeftSideView = true;
                                                  toothNumberSelectTab = 0;

                                                  debugPrint(
                                                      "-=-=-=-$isLeftSideView");
                                                  debugPrint(
                                                      "-=-=-=-$toothNumberSelectTab");
                                                } else if (elementString[0] ==
                                                    "1") {
                                                  debugPrint(
                                                      "-=-=elementString[]-1=--");
                                                  isLeftSideView = false;
                                                  toothNumberSelectTab = 0;
                                                } else if (elementString[0] ==
                                                    "3") {
                                                  debugPrint(
                                                      "-=-=elementString[]-3=--");
                                                  isLeftSideView = true;
                                                  toothNumberSelectTab = 1;
                                                } else if (elementString[0] ==
                                                    "4") {
                                                  debugPrint(
                                                      "-=-=elementString[]-4=--");
                                                  isLeftSideView = false;
                                                  toothNumberSelectTab = 1;
                                                }

                                                debugPrint(
                                                  "-=-=controller.toothNumberList-=${controller.toothNumberList}",
                                                );

                                                controller.toothNumberList.add(
                                                  {
                                                    "number": elementString[1],
                                                    "numberApi": elementString,
                                                    "isLeftSideView":
                                                        isLeftSideView,
                                                    "isUpper":
                                                        toothNumberSelectTab,
                                                  },
                                                );
                                                debugPrint(
                                                  "-=-=controller.toothNumberList-=${controller.toothNumberList}",
                                                );

                                                controller.treatmentToothNumber
                                                        .value.text =
                                                    controller.toothNumberList
                                                        .map((element) =>
                                                            element[
                                                                "numberApi"])
                                                        .toList()
                                                        .join(", ");
                                              }
                                            },
                                          );
                                        }

                                        controller.isAddTreatmentActive.value =
                                            true;
                                        controller.isEditTreatmentActive.value =
                                            true;
                                      },
                                      child: Container(
                                        height: MySize.getHeight(20),
                                        width: MySize.getWidth(20),
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.blue,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          imageSvgPath + "edit_icon.svg",
                                          height: MySize.getHeight(10),
                                          width: MySize.getWidth(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing.height(3),
                                Text(
                                  (!isNullEmptyOrFalse(controller
                                          .activeTreatmentList[index]
                                          .procedures))
                                      ? controller.activeTreatmentList[index]
                                          .procedures!.last.name
                                          .toString()
                                      : controller
                                          .activeTreatmentList[index].name
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
                            ).format(double.parse(
                                (controller.activeTreatmentList[index].amount!)
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
                        controller.activeTreatmentList[index].procedures))
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
                                      controller.activeTreatmentList[index]
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
                                                        .activeTreatmentList[
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
                                                          .activeTreatmentList[
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
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: MySize.getWidth(11),
                                            bottom: MySize.getWidth(7),
                                          ),
                                          height: MySize.getHeight(30),
                                          width: MySize.getWidth(1),
                                          color: Colors.black,
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.treatmentId.value = controller
                                        .activeTreatmentList[index].id
                                        .toString();
                                    controller.addProcedureIndex.value = index;
                                    controller.isActionBottomActive.value =
                                        false;
                                    controller.isAddTreatmentActive.value =
                                        false;
                                    controller.isAddProcedureActive.value =
                                        true;
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: MySize.getHeight(24),
                                          width: MySize.getWidth(24),
                                          decoration: const BoxDecoration(
                                              color: AppColor.blue,
                                              shape: BoxShape.circle),
                                          child: Container(
                                            height: MySize.getHeight(12),
                                            width: MySize.getWidth(12),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        width: MySize.getWidth(16),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MySize.getHeight(22),
                                            width: MySize.getWidth(115),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColor.blue,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.getHeight(15)),
                                            ),
                                            child: Text(
                                              "Add Procedure",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      MySize.getHeight(14),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                /*Center(
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showConfirmationDialog(
                                              context: context,
                                              cancelText: "No",
                                              submitText: "Yes",
                                              cancelBackColor: AppColor.blue,
                                              submitBackColor: AppColor.blue,
                                              cancelTextColor: AppColor.white,
                                              submitTextColor: Colors.white,
                                              cancelCallback: () {
                                                Get.back();
                                              },
                                              submitCallBack: () {
                                                controller.isActionBottomActive
                                                    .value = false;
                                                Get.back();

                                                controller.callCompleteTreatmentApi(
                                                  context: context,
                                                  treatmentId: controller
                                                      .activeTreatmentList[index].id
                                                      .toString(),
                                                );
                                              },
                                              contentWidget: Column(
                                                children: [
                                                  Text(
                                                    "Treatment Complete",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MySize.getHeight(17),
                                                    ),
                                                  ),
                                                  Spacing.height(5),
                                                  Text(
                                                    "Are you sure?",
                                                    style: TextStyle(
                                                      fontSize:
                                                          MySize.getHeight(13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                vertical: MySize.getHeight(26)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: MySize.getHeight(5),
                                                horizontal: MySize.getWidth(12)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(
                                                        MySize.getHeight(2),
                                                        MySize.getHeight(3),
                                                      ),
                                                      blurRadius:
                                                          MySize.getHeight(1),
                                                      spreadRadius:
                                                          MySize.getHeight(1)),
                                                ],
                                                borderRadius: BorderRadius.circular(
                                                    MySize.getHeight(20))),
                                            child: Text(
                                              "Mark as completed",
                                              style: TextStyle(
                                                color: AppColor.blue,
                                                fontSize: MySize.getHeight(12),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )*/
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      // InkWell(
                      //   onTap: () {
                      //     controller.treatmentId.value = controller
                      //         .activeTreatmentList[index].id
                      //         .toString();
                      //     controller.addProcedureIndex.value = index;
                      //     controller.isAddTreatmentActive.value = false;
                      //     controller.isAddProcedureActive.value = true;
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       vertical: MySize.getHeight(6),
                      //     ),
                      //     margin: EdgeInsets.symmetric(
                      //         vertical: MySize.getHeight(6)),
                      //     decoration: BoxDecoration(
                      //         color: AppColor.white,
                      //         borderRadius:
                      //             BorderRadius.circular(MySize.getHeight(10))),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Container(
                      //             alignment: Alignment.center,
                      //             height: MySize.getHeight(24),
                      //             width: MySize.getWidth(24),
                      //             decoration: const BoxDecoration(
                      //                 color: AppColor.blue,
                      //                 shape: BoxShape.circle),
                      //             child: Container(
                      //               height: MySize.getHeight(12),
                      //               width: MySize.getWidth(12),
                      //               decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Colors.white),
                      //             )),
                      //         SizedBox(
                      //           width: MySize.getWidth(16),
                      //         ),
                      //         Text(
                      //           "Click to add procedure",
                      //           style: TextStyle(
                      //               color: AppColor.blue,
                      //               fontSize: MySize.getHeight(12),
                      //               fontWeight: FontWeight.w500),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Center(
                        child: FittedBox(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showConfirmationDialog(
                                    context: context,
                                    cancelText: "No",
                                    submitText: "Yes",
                                    cancelBackColor: AppColor.blue,
                                    submitBackColor: AppColor.blue,
                                    cancelTextColor: AppColor.white,
                                    submitTextColor: Colors.white,
                                    cancelCallback: () {
                                      Get.back();
                                    },
                                    submitCallBack: () {
                                      controller.isActionBottomActive.value =
                                          false;
                                      Get.back();

                                      controller.callCompleteTreatmentApi(
                                        context: context,
                                        treatmentId: controller
                                            .activeTreatmentList[index].id
                                            .toString(),
                                      );
                                    },
                                    contentWidget: Column(
                                      children: [
                                        Text(
                                          "Treatment Complete",
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
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    vertical: isNullEmptyOrFalse(controller
                                            .activeTreatmentList[index]
                                            .procedures)
                                        ? 8
                                        : MySize.getHeight(26),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: MySize.getHeight(5),
                                      horizontal: MySize.getWidth(12)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(
                                              MySize.getHeight(2),
                                              MySize.getHeight(3),
                                            ),
                                            blurRadius: MySize.getHeight(1),
                                            spreadRadius: MySize.getHeight(1)),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          MySize.getHeight(20))),
                                  child: Text(
                                    "Mark as completed",
                                    style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: MySize.getHeight(12),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
            if (index != controller.activeTreatmentList.length - 1)
              SizedBox(
                height: 0,
                child: Divider(),
              ),
          ],
        ),
      );
    });
  }
}
