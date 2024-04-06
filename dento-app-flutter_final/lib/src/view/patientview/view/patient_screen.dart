import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/src/view/home/component/common_name_dot_colum.dart';
import 'package:Dentosupport_mini/src/view/paymentsummary/view/payment_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/services/date_picker/date_picker_widget.dart';
import '../../home/component/home_screen_bottom.dart';
import '../component/patient_bottom_sheet.dart';

class PatientScreen extends StatelessWidget {
  PatientScreen({Key? key}) : super(key: key);
  final DatePickerController _controller = DatePickerController();
  List<Map<String, dynamic>> list = [
    {"name": "RCT-26", "clinicName": "BMP"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 10),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(2, 2))
            ]),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.blue,
                        size: 17,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Dushyanta Gopivallabha",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: AppColor.blue)),
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColor.blue,
                      ),
                    )
                  ],
                ),
                const Text(
                  "(38/male)",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8E8E92)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "9876543219",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColor.blue),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "No previous medical history.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8E8E92)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.edit,
                      color: AppColor.blue,
                      size: 14,
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [patienCompactView()],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: PatientBottomSheet(),
    );
  }

  patienCompactView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            bottom: 14.0,
            left: 5.0,
            right: 5.0,
          ),
          child: DatePicker(
            DateTime.now(),
            controller: _controller,
            initialSelectedDate: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day + 2,
            ),
            inactiveDates: [DateTime.now()],
            selectionColor: AppColor.blue,
            selectedTextColor: AppColor.white,
            dateTextStyle: const TextStyle(fontSize: 14),
            deactivatedColor: AppColor.black,
            onDateChange: (date) {
              // New date selected
              /*setState(
                        () {
                      _selectedValue = date;
                      shareBottomSheet(date: _selectedValue);
                    },
                  );*/
            },
          ),
        ),
        const Text(
          "No visit scheduled",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.blue),
        ),
        Container(
          margin: const EdgeInsets.only(top: 27, left: 24, right: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(1, 0))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Treatment Summary",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                      title: Row(
                        children: [
                          commonNameColum(
                              dotColor: AppColor.blue,
                              name: "RCT-26",
                              clinicName: "BMP",
                              nameColor: Colors.black,
                              clinicNameColor: Color(0xff575757)),
                          Spacer(),
                          Text(
                            "-1,500",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 13),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          decoration: BoxDecoration(
                              color: AppColor.grayBackground,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                        color: AppColor.blue,
                                        shape: BoxShape.circle),
                                    child: const Text(
                                      "1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Access Opening",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Access Opening",
                                        style: TextStyle(
                                            color: Color(0xff555555),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 30,
                                width: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 24,
                                    width: 24,
                                    decoration: const BoxDecoration(
                                        color: AppColor.blue,
                                        shape: BoxShape.circle),
                                    child: const Text(
                                      "2",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "BMP",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "01-08-2022",
                                        style: TextStyle(
                                            color: Color(0xff555555),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 30,
                                width: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 24,
                                      width: 24,
                                      decoration: const BoxDecoration(
                                          color: AppColor.blue,
                                          shape: BoxShape.circle),
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Click to add procedure",
                                        style: TextStyle(
                                            color: AppColor.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 26),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: const Text(
                                      "Mark as completed",
                                      style: TextStyle(
                                          color: AppColor.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              )
                            ],
                          ),
                        )
                      ]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 20,
                    color: Color(0xffD4D4D4),
                  );
                },
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => PaymentSummaryScreen());
          },
          child: Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
                color: Color(0xffE8F0FE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.blue),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          "Add New Treatment",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blue),
                        ),
                        Text(
                          "Click here to add procedure",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 27, left: 24, right: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(1, 0))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Completed Treatments",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Spacer(),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      commonNameColum(
                          dotColor: AppColor.blue,
                          name: "RCT-26",
                          clinicName: "Last Procedure - 27/12/22",
                          nameColor: Colors.black,
                          clinicNameColor: Color(0xff575757)),
                      const Spacer(),
                      const Text(
                        "-1,500",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 11,
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 30,
                    color: Color(0xffD4D4D4),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  emptyPatientView() {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 27, left: 24, right: 24),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0,
                      spreadRadius: 0,
                      offset: Offset(1, 0))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              children: [
                Text(
                  "Treatment Summary",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
                color: Color(0xffE8F0FE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.blue),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          "Add New Treatment",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blue),
                        ),
                        Text(
                          "Click here to add procedure",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1, 1))
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {}, child: Image.asset(AppAsset.patientEmpty)),
                  Text(
                    "No Treatment Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
