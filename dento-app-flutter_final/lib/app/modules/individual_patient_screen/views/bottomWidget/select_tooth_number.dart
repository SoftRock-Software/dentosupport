import 'package:Dentosupport_mini/app/modules/individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectToothNumber extends StatefulWidget {
  const SelectToothNumber({Key? key}) : super(key: key);

  @override
  State<SelectToothNumber> createState() => _SelectToothNumberState();
}

class _SelectToothNumberState extends State<SelectToothNumber> {
  IndividualPatientScreenController individualPatientScreenController = Get.put(
    IndividualPatientScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 4,
                  bottom: 16,
                ),
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColor.grayLine,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
          /* Column(
            children: [
              Text(
                "Upper",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blue,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 4,
                ),
                height: 2,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),*/

          Obx(
            () => Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: false,
                      physics: NeverScrollableScrollPhysics(),
                      onTap: (int) {
                        debugPrint("-=-=int-=--$int");
                        individualPatientScreenController
                            .toothNumberSelectTab.value = int;
                      },
                      padding: EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      indicatorColor: AppColor.blue,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text(
                            "Upper",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                          ),
                          child: Text(
                            "Lower",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // first tab bar view widget
                            if (individualPatientScreenController
                                    .toothNumberSelectTab.value ==
                                0)
                              upperToothView(),

                            // second tab bar viiew widget
                            if (individualPatientScreenController
                                    .toothNumberSelectTab.value ==
                                1)
                              LowerToothView(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 15.73,
            ),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: getButton(
                title: "Save",
                height: 51,
                fontSize: 15,
                borderRadius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  upperToothView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 46.0,
              bottom: 24.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Upper right",
                    style: TextStyle(
                      color: AppColor.blackText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 180,
                ),
                Expanded(
                  child: Text(
                    "Upper left",
                    style: TextStyle(
                      color: AppColor.blackText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        digitShowViewUpper(
                          number: "3",
                          rcMargin: 70,
                          bcMargin: 0,
                          tcMargin: 30,
                        ),
                        digitShowViewUpper(
                          number: "2",
                          rcMargin: 40,
                          bcMargin: 0,
                          tcMargin: 10,
                        ),
                        digitShowViewUpper(
                          number: "1",
                          rcMargin: 5,
                          bcMargin: 0,
                          tcMargin: 0,
                        ),
                      ],
                    ),
                    digitShowViewUpper(
                      number: "4",
                      rcMargin: 90,
                      bcMargin: 5,
                    ),
                    digitShowViewUpper(
                      number: "5",
                      rcMargin: 58,
                      bcMargin: 5,
                      // rcMargin: 85,
                    ),
                    digitShowViewUpper(
                      number: "6",
                      rcMargin: 105,
                    ),
                    digitShowViewUpper(
                      number: "7",
                      rcMargin: 105,
                    ),
                    digitShowViewUpper(
                      number: "8",
                      rcMargin: 105,
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashLength: 2,
                dashGapLength: 2,
                lineThickness: 1,
                dashColor: AppColor.black,
                // dashGapColor: Colors.red,
                direction: Axis.vertical,
                lineLength: 233.5,
              ),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        digitShowViewUpper(
                          number: "3",
                          lcMargin: 70,
                          bcMargin: 0,
                          tcMargin: 30,
                          isLeftSideView: false,
                        ),
                        digitShowViewUpper(
                          number: "2",
                          lcMargin: 40,
                          bcMargin: 0,
                          tcMargin: 10,
                          isLeftSideView: false,
                        ),
                        digitShowViewUpper(
                          number: "1",
                          lcMargin: 5,
                          bcMargin: 0,
                          tcMargin: 0,
                          isLeftSideView: false,
                        ),
                      ],
                    ),
                    digitShowViewUpper(
                      number: "4",
                      lcMargin: 90,
                      bcMargin: 5,
                      isLeftSideView: false,
                    ),
                    digitShowViewUpper(
                      number: "5",
                      lcMargin: 58,
                      bcMargin: 5,
                      isLeftSideView: false,
                      // rcMargin: 85,
                    ),
                    digitShowViewUpper(
                      number: "6",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowViewUpper(
                      number: "7",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowViewUpper(
                      number: "8",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                  ],
                ),
              ),

              /*Expanded(
                child: Column(
                  children: [
                    digitShowView(
                      number: "8",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "7",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "6",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "5",
                      lcMargin: 55,
                      // lcMargin: 5,
                      isLeftSideView: false,
                      // rcMargin: 85,
                    ),
                    digitShowView(
                      number: "4",
                      lcMargin: 90,
                      bcMargin: 0,
                      // lcMargin: 1,
                      isLeftSideView: false,
                    ),
                    Stack(
                      children: [
                        digitShowView(
                          number: "3",
                          lcMargin: 70,
                          bcMargin: 0,
                          isLeftSideView: false,
                        ),
                        digitShowView(
                          number: "2",
                          lcMargin: 40,
                          // lcMargin: 0,
                          tcMargin: 24,
                          isLeftSideView: false,
                        ),
                        digitShowView(
                          number: "1",
                          lcMargin: 5,
                          // lcMargin: 0,
                          tcMargin: 35,
                          isLeftSideView: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  LowerToothView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 46.0,
              bottom: 24.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Lower right",
                    style: TextStyle(
                      color: AppColor.blackText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 180,
                ),
                Expanded(
                  child: Text(
                    "Lower left",
                    style: TextStyle(
                      color: AppColor.blackText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    digitShowViewLower(
                      number: "8",
                      rcMargin: 105,
                    ),
                    digitShowViewLower(
                      number: "7",
                      rcMargin: 105,
                    ),
                    digitShowViewLower(
                      number: "6",
                      rcMargin: 105,
                    ),
                    digitShowViewLower(
                      number: "5",
                      rcMargin: 55,
                      bcMargin: 5,
                      // rcMargin: 85,
                    ),
                    digitShowViewLower(
                      number: "4",
                      rcMargin: 90,
                      bcMargin: 1,
                    ),
                    Stack(
                      children: [
                        digitShowViewLower(
                          number: "3",
                          rcMargin: 70,
                          bcMargin: 0,
                        ),
                        digitShowViewLower(
                          number: "2",
                          rcMargin: 40,
                          bcMargin: 0,
                          tcMargin: 24,
                        ),
                        digitShowViewLower(
                          number: "1",
                          rcMargin: 5,
                          bcMargin: 0,
                          tcMargin: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: DottedLine(
                  dashLength: 2,
                  dashGapLength: 2,
                  lineThickness: 1,
                  dashColor: AppColor.black,
                  // dashGapColor: Colors.red,
                  direction: Axis.vertical,
                  lineLength: 233.5,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    digitShowViewLower(
                      number: "8",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowViewLower(
                      number: "7",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowViewLower(
                      number: "6",
                      lcMargin: 105,
                      isLeftSideView: false,
                    ),
                    digitShowViewLower(
                      number: "5",
                      lcMargin: 55,
                      // lcMargin: 5,
                      isLeftSideView: false,
                      // rcMargin: 85,
                    ),
                    digitShowViewLower(
                      number: "4",
                      lcMargin: 90,
                      bcMargin: 0,
                      // lcMargin: 1,
                      isLeftSideView: false,
                    ),
                    Stack(
                      children: [
                        digitShowViewLower(
                          number: "3",
                          lcMargin: 70,
                          bcMargin: 0,
                          isLeftSideView: false,
                        ),
                        digitShowViewLower(
                          number: "2",
                          lcMargin: 40,
                          // lcMargin: 0,
                          tcMargin: 24,
                          isLeftSideView: false,
                        ),
                        digitShowViewLower(
                          number: "1",
                          lcMargin: 5,
                          // lcMargin: 0,
                          tcMargin: 35,
                          isLeftSideView: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /*Expanded(
                child: Column(
                  children: [
                    digitShowView(
                      number: "8",
                      lcMargin: 90,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "7",
                      lcMargin: 90,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "6",
                      lcMargin: 90,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "5",
                      lcMargin: 42,
                      // lcMargin: 85,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "4",
                      lcMargin: 75,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "3",
                      lcMargin: 55,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "2",
                      lcMargin: 30,
                      isLeftSideView: false,
                    ),
                    digitShowView(
                      number: "1",
                      lcMargin: 5,
                      isLeftSideView: false,
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  digitShowViewUpper({
    String? number,
    double? lcPadding,
    double? tcPadding,
    double? rcPadding,
    double? bcPadding,
    double? lcMargin,
    double? tcMargin,
    double? rcMargin,
    double? bcMargin,
    // MainAxisAlignment? mainAxisAlignment,
    bool? isLeftSideView = true,
  }) {
    return Obx(
      () => Row(
        mainAxisAlignment: /* mainAxisAlignment ?? */ isLeftSideView == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          number == "5" && isLeftSideView == false
              ? Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    individualPatientScreenController
                                .toothNumberSelectTab.value ==
                            0
                        ? "2"
                        : "3",
                    style: TextStyle(
                      color: AppColor.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : SizedBox(),
          GestureDetector(
            onTap: () {
              // individualPatientScreenController.toothNumberList.clear();
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );

             /* debugPrint("-=-isLeftSideView=-=-=-$isLeftSideView");
              debugPrint("-=-isLeftSideView=-=-=-${individualPatientScreenController
                  .toothNumberSelectTabApi.value}");
              debugPrint("-=-isLeftSideView=-=-=-${individualPatientScreenController
                  .toothNumberSelectTab.value}");*/


              if (isLeftSideView == true &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      0) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 1;
              } else if (isLeftSideView == false &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      0) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 2;
              } else if (isLeftSideView == true &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      1) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 4;
              } else if (isLeftSideView == false &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      1) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 3;
              }

              /*if (individualPatientScreenController.toothNumberListApi
                  .contains(number)) {
                individualPatientScreenController.toothNumberListApi.remove(
                  number,
                );
              } else {
                individualPatientScreenController.toothNumberListApi.add(
                  number!,
                );
              }*/
              var data = {
                "number": number!,
                "numberApi": int.parse(
                  "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                ),
                "isLeftSideView": isLeftSideView,
                "isUpper": individualPatientScreenController
                    .toothNumberSelectTab.value,
              };

              debugPrint("-=data-=-=$data");

              /* var index = individualPatientScreenController.toothNumberList
                  .indexWhere((p0) =>
              (p0["number"] == number) &&
                  (p0["isLeftSideView"] == isLeftSideView) &&
                  (p0["isUpper"] ==
                      individualPatientScreenController
                          .toothNumberSelectTab.value));*/

              if (individualPatientScreenController.toothNumberList
                      .where((p0) =>
                          (p0["number"] == number) &&
                          /*(p0["numberApi"] ==
                              int.parse(
                                "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                              )) &&*/
                          (p0["isLeftSideView"] == isLeftSideView) &&
                          (p0["isUpper"] ==
                              individualPatientScreenController
                                  .toothNumberSelectTab.value))
                      .length >
                  0) {
                print('8888888888');
                individualPatientScreenController.toothNumberList.removeWhere(
                    (p0) =>
                        (p0["number"] == number) &&
                        /*(p0["numberApi"] ==
                            int.parse(
                              "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                            )) &&*/
                        (p0["isLeftSideView"] == isLeftSideView) &&
                        (p0["isUpper"] ==
                            individualPatientScreenController
                                .toothNumberSelectTab.value));
              } else {
                individualPatientScreenController.toothNumberList.add(data);
              }

              /*individualPatientScreenController.toothNumberListApi
                  .map((element) => element["numberApi"])
                  .toList();*/

              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList.map((element) => element["numberApi"]).toList().join(", ")}",
              );
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );
              individualPatientScreenController
                      .treatmentToothNumber.value.text =
                  individualPatientScreenController.toothNumberList
                      .map((element) => element["numberApi"])
                      .toList()
                      .join(", ");

              debugPrint(
                  "-=-=-=--=${individualPatientScreenController.treatmentToothNumber.value.text}");
            },
            child: Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.only(
                left: lcPadding ?? 0,
                top: tcPadding ?? 0,
                right: rcPadding ?? 0,
                bottom: bcPadding ?? 0,
              ),
              margin: EdgeInsets.only(
                left: lcMargin ?? 0,
                top: tcMargin ?? 0,
                right: rcMargin ?? 0,
                bottom: bcMargin ?? 7,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.blue,
                  width: 1.5,
                ),
                color: individualPatientScreenController.toothNumberList
                            .where((p0) =>
                                (p0["number"] == number) &&
                                (p0["isLeftSideView"] == isLeftSideView) &&
                                (p0["isUpper"] ==
                                    individualPatientScreenController
                                        .toothNumberSelectTab.value))
                            .length >
                        0
                    ? AppColor.blue
                    : AppColor.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number!,
                  style: TextStyle(
                    color: individualPatientScreenController.toothNumberList
                                .where((p0) =>
                                    (p0["number"] == number) &&
                                    (p0["isLeftSideView"] == isLeftSideView) &&
                                    (p0["isUpper"] ==
                                        individualPatientScreenController
                                            .toothNumberSelectTab.value))
                                .length >
                            0
                        ? AppColor.white
                        : AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          number == "5" && isLeftSideView == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    individualPatientScreenController
                                .toothNumberSelectTab.value ==
                            0
                        ? "1"
                        : "4",
                    style: TextStyle(
                      color: AppColor.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  digitShowViewLower({
    String? number,
    double? lcPadding,
    double? tcPadding,
    double? rcPadding,
    double? bcPadding,
    double? lcMargin,
    double? tcMargin,
    double? rcMargin,
    double? bcMargin,
    // MainAxisAlignment? mainAxisAlignment,
    bool? isLeftSideView = true,
  }) {
    return Obx(
      () => Row(
        mainAxisAlignment: /* mainAxisAlignment ?? */ isLeftSideView == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          number == "5" && isLeftSideView == false
              ? Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    individualPatientScreenController
                                .toothNumberSelectTab.value ==
                            0
                        ? "2"
                        : "3",
                    style: TextStyle(
                      color: AppColor.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : SizedBox(),
          GestureDetector(
            onTap: () {
              // individualPatientScreenController.toothNumberList.clear();
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );

              if (isLeftSideView == true &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      0) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 1;
              } else if (isLeftSideView == false &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      0) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 2;
              } else if (isLeftSideView == true &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      1) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 4;
              } else if (isLeftSideView == false &&
                  individualPatientScreenController
                          .toothNumberSelectTab.value ==
                      1) {
                individualPatientScreenController
                    .toothNumberSelectTabApi.value = 3;
              }

              /*if (individualPatientScreenController.toothNumberListApi
                  .contains(number)) {
                individualPatientScreenController.toothNumberListApi.remove(
                  number,
                );
              } else {
                individualPatientScreenController.toothNumberListApi.add(
                  number!,
                );
              }*/
              var data = {
                "number": number!,
                "numberApi": int.parse(
                  "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                ),
                "isLeftSideView": isLeftSideView,
                "isUpper": individualPatientScreenController
                    .toothNumberSelectTab.value,
              };

              /* var index = individualPatientScreenController.toothNumberList
                  .indexWhere((p0) =>
              (p0["number"] == number) &&
                  (p0["isLeftSideView"] == isLeftSideView) &&
                  (p0["isUpper"] ==
                      individualPatientScreenController
                          .toothNumberSelectTab.value));*/

              if (individualPatientScreenController.toothNumberList
                      .where((p0) =>
                          (p0["number"] == number) &&
                          /*(p0["numberApi"] ==
                              int.parse(
                                "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                              )) &&*/
                          (p0["isLeftSideView"] == isLeftSideView) &&
                          (p0["isUpper"] ==
                              individualPatientScreenController
                                  .toothNumberSelectTab.value))
                      .length >
                  0) {
                print('8888888888');
                individualPatientScreenController.toothNumberList.removeWhere(
                    (p0) =>
                        (p0["number"] == number) &&
                        /*(p0["numberApi"] ==
                            int.parse(
                              "${individualPatientScreenController.toothNumberSelectTabApi.value.toString() + number.toString()}",
                            )) &&*/
                        (p0["isLeftSideView"] == isLeftSideView) &&
                        (p0["isUpper"] ==
                            individualPatientScreenController
                                .toothNumberSelectTab.value));
              } else {
                individualPatientScreenController.toothNumberList.add(data);
              }

              /*individualPatientScreenController.toothNumberListApi
                  .map((element) => element["numberApi"])
                  .toList();*/

              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList.map((element) => element["numberApi"]).toList().join(", ")}",
              );
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );
              debugPrint(
                "-=-=toothNumberList-=-=${individualPatientScreenController.toothNumberList}",
              );
              individualPatientScreenController
                      .treatmentToothNumber.value.text =
                  individualPatientScreenController.toothNumberList
                      .map((element) => element["numberApi"])
                      .toList()
                      .join(", ");

              debugPrint(
                  "-=-=-=--=${individualPatientScreenController.treatmentToothNumber.value.text}");
            },
            child: Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.only(
                left: lcPadding ?? 0,
                top: tcPadding ?? 0,
                right: rcPadding ?? 0,
                bottom: bcPadding ?? 0,
              ),
              margin: EdgeInsets.only(
                left: lcMargin ?? 0,
                top: tcMargin ?? 0,
                right: rcMargin ?? 0,
                bottom: bcMargin ?? 7,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.blue,
                  width: 1.5,
                ),
                color: individualPatientScreenController.toothNumberList
                            .where((p0) =>
                                (p0["number"] == number) &&
                                (p0["isLeftSideView"] == isLeftSideView) &&
                                (p0["isUpper"] ==
                                    individualPatientScreenController
                                        .toothNumberSelectTab.value))
                            .length >
                        0
                    ? AppColor.blue
                    : AppColor.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number!,
                  style: TextStyle(
                    color: individualPatientScreenController.toothNumberList
                                .where((p0) =>
                                    (p0["number"] == number) &&
                                    (p0["isLeftSideView"] == isLeftSideView) &&
                                    (p0["isUpper"] ==
                                        individualPatientScreenController
                                            .toothNumberSelectTab.value))
                                .length >
                            0
                        ? AppColor.white
                        : AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          number == "5" && isLeftSideView == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    individualPatientScreenController
                                .toothNumberSelectTab.value ==
                            0
                        ? "1"
                        : "4",
                    style: TextStyle(
                      color: AppColor.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
