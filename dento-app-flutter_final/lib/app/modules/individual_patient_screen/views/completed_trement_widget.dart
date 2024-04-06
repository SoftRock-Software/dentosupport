import 'package:Dentosupport_mini/app/modules/individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/treatment_completed_list_widget.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../src/view/home/component/common_name_dot_colum.dart';

class CompletedTreatmentWidget extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();
  CompletedTreatmentWidget({required this.individualPatientScreenController});

  @override
  _CompletedTreatmentWidgetState createState() =>
      _CompletedTreatmentWidgetState();
}

class _CompletedTreatmentWidgetState extends State<CompletedTreatmentWidget> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();
  @override
  void initState() {
    controller = widget.individualPatientScreenController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MySize.getHeight(27),
          left: MySize.getWidth(24),
          right: MySize.getWidth(24)),
      padding: EdgeInsets.symmetric(
          /*horizontal: MySize.getWidth(12),*/ vertical: MySize.getHeight(14)),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: MySize.getHeight(1),
                spreadRadius: MySize.getHeight(1),
                offset: Offset(MySize.getHeight(1), MySize.getHeight(1)))
          ],
          color: AppColor.grayCardBackground,
          // color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  "Completed Treatments",
                  style: TextStyle(
                      fontSize: MySize.getHeight(16),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
              ],
            ),
          ),
          Spacing.height(5),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.completedTreatmentList.length,
            itemBuilder: (BuildContext context, int index) {
              return TreatmentCompletedListWidget(
                individualPatientScreenController: controller,
                index: index,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          ),
          if (5 < 3)
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.completedTreatmentList.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                    onExpansionChanged: (val) {
                      controller.isActionBottomActive.value = false;
                    },
                    title: Row(
                      children: [
                        commonNameColum(
                            dotColor: AppColor.blue,
                            isForComplete: true,
                            controller: controller,
                            name: controller.completedTreatmentList[index].name
                                .toString(),
                            clinicName: (!isNullEmptyOrFalse(controller
                                    .completedTreatmentList[index].procedures))
                                ? controller.completedTreatmentList[index]
                                    .procedures!.first.name
                                    .toString()
                                : controller.completedTreatmentList[index].name
                                    .toString(),
                            nameColor: Colors.black,
                            clinicNameColor: Color(0xff575757)),
                        Spacer(),
                        Text(
                          controller.completedTreatmentList[index].amount
                              .toString(),
                          style: TextStyle(
                              fontSize: MySize.getHeight(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MySize.getHeight(6),
                            horizontal: MySize.getWidth(13)),
                        margin: EdgeInsets.symmetric(
                            horizontal: MySize.getWidth(15),
                            vertical: MySize.getHeight(6)),
                        decoration: BoxDecoration(
                            color: AppColor.grayBackground,
                            borderRadius:
                                BorderRadius.circular(MySize.getHeight(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (!isNullEmptyOrFalse(controller
                                  .completedTreatmentList[index].procedures))
                              ? [
                                  Column(
                                    children: List.generate(
                                        controller.completedTreatmentList[index]
                                            .procedures!.length, (ind) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
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
                                                  width: MySize.getWidth(16)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .completedTreatmentList[
                                                            index]
                                                        .procedures![ind]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            MySize.getHeight(
                                                                14),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(controller
                                                            .completedTreatmentList[
                                                                index]
                                                            .procedures![ind]
                                                            .dateTimeCreatedAt!),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff555555),
                                                        fontSize:
                                                            MySize.getHeight(
                                                                12),
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
                                                  left: MySize.getWidth(10)),
                                              height: MySize.getHeight(30),
                                              width: MySize.getWidth(1),
                                              color: Colors.black,
                                            ),
                                        ],
                                      );
                                    }),
                                  ),
                                ]
                              : [],
                        ),
                      )
                    ]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: MySize.getHeight(20),
                  color: Color(0xffD4D4D4),
                );
              },
            ),
        ],
      ),
    );
  }
}
