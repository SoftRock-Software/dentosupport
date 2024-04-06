import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../main.dart';
import '../../../../src/routes/app_pages.dart';
import '../controllers/add_patient_and_home_screen_controller.dart';

class GetPatientListWidgetHomeScreen extends StatefulWidget {
  AddPatientAndHomeScreenController addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();

  GetPatientListWidgetHomeScreen(
      {required this.addPatientAndHomeScreenController});

  @override
  State<GetPatientListWidgetHomeScreen> createState() =>
      _GetPatientListWidgetHomeScreenState();
}

class _GetPatientListWidgetHomeScreenState
    extends State<GetPatientListWidgetHomeScreen> {
  AddPatientAndHomeScreenController controller =
      AddPatientAndHomeScreenController();
  bool isFirstTimeSignup = false;

  @override
  void initState() {
    controller = widget.addPatientAndHomeScreenController;
    if (!isNullEmptyOrFalse(box.read(ArgumentConstant.firstTimeSignUp))) {
      if (box.read(ArgumentConstant.firstTimeSignUp)) {
        isFirstTimeSignup = true;
        box.write(ArgumentConstant.firstTimeSignUp, false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          child: Column(
            children: [
              // if (!isFirstTimeSignup/*controller.patientList.isNotEmpty*/)
              // (isNullEmptyOrFalse(controller.patientList)) ||
              //         (isNullEmptyOrFalse(controller.patientList[0].patient)) ||
              // controller.patientList.length < 3 &&

              // || (isNullEmptyOrFalse(controller.patientList[0].patient))
              controller.isAddPatientActive.isTrue ||
                      controller.noOfVisitor.value == 0
                  ? SizedBox()
                  : Container(
                      height: MySize.getHeight(60),
                      padding: EdgeInsets.only(left: MySize.getWidth(25)),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            color: Colors.black12,
                            spreadRadius: MySize.getHeight(2),
                            blurRadius: MySize.getHeight(10),
                          )
                        ],
                      ),
                      child: Container(
                        width: MySize.getWidth(200),
                        child: getTopFilterWidget2(),
                      ),
                    ),
              controller.isAddPatientActive.isTrue
                  ? SizedBox(
                      child: Image.asset(
                      "assets/images/png/type_view.png",
                    ) /*SvgPicture.asset(
                        "assets/images/svg/type_view.svg",
                      ),*/
                      )
                  : Expanded(
                      child: (isNullEmptyOrFalse(controller.patientList)) ||
                              // controller.isAddPatientActive.isTrue ||
                              controller.noOfVisitor.value == 0
                          ? Container(
                              margin: EdgeInsets.only(
                                bottom: 100,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.selectedFilter.value == "Today"
                                      ? SvgPicture.asset(
                                          imageSvgPath + "add_patient_logo.svg",
                                        )
                                      : Image.asset(
                                          imagePngPath + "no_patient_found.png",
                                        ),
                                  SizedBox(
                                    height: MySize.getHeight(10),
                                  ),
                                  Text(
                                    (controller.selectedFilter.value == "Today")
                                        ? "Add Patients"
                                        : "No Patients attended",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MySize.getHeight(18)),
                                  ),
                                  SizedBox(height: MySize.getHeight(10)),
                                  if (controller.selectedFilter.value ==
                                      "Today")
                                    Text(
                                      "Use Search to add new patient",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: MySize.getHeight(16)),
                                    ),
                                ],
                              ),
                            )
                          : GroupedListView<dynamic, String>(
                              elements: controller.patientList,
                              padding: EdgeInsets.only(
                                top: MySize.getHeight(20),
                                left: MySize.getWidth(20),
                                right: MySize.getWidth(20),
                                bottom: (controller.isAddPatientActive.isTrue)
                                    ? MySize.getHeight(400)
                                    : MySize.getHeight(200),
                              ),

                              groupBy: (element) {
                                return DateTime.parse(element.createdAt)
                                    .toLocal()
                                    .toString()
                                    .substring(0, 10);
                              },
                              groupComparator: (value1, value2) =>
                                  value2.compareTo(value1),
                              itemComparator: (item1, item2) =>
                                  (item2.createdAt).compareTo(item1.createdAt),
                              // order: GroupedListOrder.ASC,
                              // useStickyGroupSeparators: true,
                              groupSeparatorBuilder: (String value) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (controller.selectedFilter.value ==
                                        "Older")
                                    ? Column(
                                        children: [
                                          Text(
                                            DateFormat("dd MMM, yyyy")
                                                .format(DateTime.parse(value)),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          // Divider(),
                                          // MySize.getHeight(5);
                                        ],
                                      )
                                    : Container(),
                              ),
                              itemBuilder: (context, patientListItem) {
                                return (!isNullEmptyOrFalse(
                                        patientListItem.patient))
                                    ? Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              debugPrint("-=-=-=-");

                                              // controller.isSearchStarted.value = false;

                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                              Get.toNamed(
                                                  Routes
                                                      .INDIVIDUAL_PATIENT_SCREEN,
                                                  arguments: {
                                                    ArgumentConstant.patientId:
                                                        patientListItem
                                                            .patient!.id
                                                            .toString(),
                                                    ArgumentConstant
                                                            .patientName:
                                                        patientListItem
                                                            .patient!.name
                                                            .toString(),
                                                    ArgumentConstant
                                                            .lastVisitedDate:
                                                        patientListItem.patient!
                                                            .lastVisitedDate
                                                            .toString(),
                                                    ArgumentConstant.patientAge:
                                                        patientListItem
                                                            .patient!.age
                                                            .toString(),
                                                    ArgumentConstant
                                                            .patientGender:
                                                        patientListItem
                                                            .patient!.gender
                                                            .toString(),
                                                    ArgumentConstant
                                                            .patientNumber:
                                                        patientListItem
                                                            .patient!.mobile
                                                            .toString(),
                                                  });
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: MySize.getWidth(
                                                            250),
                                                        child: Text(
                                                          patientListItem
                                                              .patient!.name
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      17)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MySize.getWidth(
                                                            250),
                                                        child: Text(
                                                          (!isNullEmptyOrFalse(
                                                                  patientListItem
                                                                      .patient!
                                                                      .treatments))
                                                              ? (!isNullEmptyOrFalse(patientListItem
                                                                      .patient!
                                                                      .treatments![
                                                                          0]
                                                                      .procedures))
                                                                  ? patientListItem
                                                                          .patient!
                                                                          .treatments![
                                                                              0]
                                                                          .procedures![
                                                                              0]
                                                                          .name
                                                                          .toString() +
                                                                      (patientListItem.patient!.treatments![0].toothNumber ==
                                                                              null
                                                                          ? ""
                                                                          : patientListItem.patient!.treatments![0].toothNumber ==
                                                                                  []
                                                                              ? ""
                                                                              : " - ${patientListItem.patient!.treatments![0].toothNumber!.toList().join(", ").toString()}")
                                                                  : patientListItem
                                                                          .patient!
                                                                          .treatments![
                                                                              0]
                                                                          .name
                                                                          .toString() +
                                                                      (patientListItem.patient!.treatments![0].toothNumber ==
                                                                              null
                                                                          ? ""
                                                                          : patientListItem.patient!.treatments![0].toothNumber == []
                                                                              ? ""
                                                                              : patientListItem.patient!.treatments![0].toothNumber.toString() == "[" "]"
                                                                                  ? ""
                                                                                  : " - ${patientListItem.patient!.treatments![0].toothNumber!.toList().join(", ").toString()}")
                                                              : "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: MySize
                                                                .getHeight(15),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  patientListItem.patient!
                                                          .transactions!.isEmpty
                                                      ? SizedBox()
                                                      : Text(
                                                          patientListItem
                                                              .patient!
                                                              .transactions![0]
                                                              .amount
                                                              .toString(),
                                                          /*controller.patientList[index]
                                                        .patient!.remainBill
                                                        .toString(),*/
                                                          style: TextStyle(
                                                              fontSize: MySize
                                                                  .getHeight(
                                                                      14),
                                                              color: Color(
                                                                  0xff555555),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                  Spacing.width(5),
                                                  Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Color(0xff555555),
                                                      size:
                                                          MySize.getHeight(15)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MySize.getHeight(20),
                                            child: Divider(),
                                          ),
                                        ],
                                      )
                                    : SizedBox();
                              },
                            ),
                    ),
            ],
          ),
        ),
      );
    });
  }

  Widget getTopFilterWidget2() {
    return InkWell(
      onTap: () {
        controller.searchController.value.clear();
        FocusManager.instance.primaryFocus!.unfocus();

        if (controller.selectedFilter.value == "Today") {
          controller.selectedFilter.value = "Yesterday";
          controller.callGetPatientListApi(
            context: context,
            dateFilter:
                "?day=Yesterday&clinicId=${box.read(ArgumentConstant.clinicId)}",
            isLoaderShow: true,
            // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 1)))}&clinicId=${box.read(ArgumentConstant.clinicId)}",
          );
        } else if (controller.selectedFilter.value == "Yesterday") {
          controller.selectedFilter.value = "Older";
          controller.callGetPatientListApi(
            context: context,
            dateFilter:
                "?day=Older&clinicId=${box.read(ArgumentConstant.clinicId)}",
            isLoaderShow: true,
            // dateFilter: "?clinicId=${box.read(ArgumentConstant.clinicId)}",
          );
        } else {
          controller.selectedFilter.value = "Today";
          controller.callGetPatientListApi(
            context: context,
            dateFilter:
                "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
            isLoaderShow: true,
            // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
          );
        }

        controller.selectedFilter.refresh();
      },
      child: Row(
        children: [
          Text(
            controller.selectedFilter.value,
            style: TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.w500,
                fontSize: MySize.getHeight(17)),
          ),
          SvgPicture.asset(
            imageSvgPath + "filter_arrow_icon.svg",
            height: 24,
            width: 24,
          ),
        ],
      ),
    );
  }

  Widget getTopFilterWidget() {
    return PopupMenuButton(
      offset: Offset(MySize.getHeight(-10), MySize.getHeight(35)),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              controller.searchController.value.clear();
              FocusManager.instance.primaryFocus!.unfocus();
              controller.selectedFilter.value = "Today";
              controller.selectedFilter.refresh();
              controller.callGetPatientListApi(
                  context: context,
                  dateFilter:
                      "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}");
            },
            child: Text(
              "Today",
              style: TextStyle(
                  color: AppColor.blue, fontSize: MySize.getHeight(17)),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              controller.searchController.value.clear();
              FocusManager.instance.primaryFocus!.unfocus();
              controller.selectedFilter.value = "Yesterday";
              print(box.read(ArgumentConstant.clinicId));
              controller.selectedFilter.refresh();
              controller.callGetPatientListApi(
                  context: context,
                  dateFilter:
                      "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 1)))}&clinicId=${box.read(ArgumentConstant.clinicId)}");
            },
            child: Text(
              "Yesterday",
              style: TextStyle(
                  color: AppColor.blue, fontSize: MySize.getHeight(17)),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              controller.searchController.value.clear();
              FocusManager.instance.primaryFocus!.unfocus();
              controller.selectedFilter.value = "Older";
              controller.selectedFilter.refresh();
              controller.callGetPatientListApi(
                  context: context,
                  dateFilter:
                      "?clinicId=${box.read(ArgumentConstant.clinicId)}");
            },
            child: Text(
              "Older",
              style: TextStyle(
                  color: AppColor.blue, fontSize: MySize.getHeight(17)),
            ),
          ),
        ];
      },
      child: Row(
        children: [
          Text(
            controller.selectedFilter.value,
            style: TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.w500,
                fontSize: MySize.getHeight(17)),
          ),
          SvgPicture.asset(
            imageSvgPath + "filter_arrow_icon.svg",
            height: 26,
          ),
        ],
      ),
    );
  }
}
