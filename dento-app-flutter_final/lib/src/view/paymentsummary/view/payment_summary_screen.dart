import 'package:Dentosupport_mini/src/view/paymentsummary/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';

class PaymentSummaryScreen extends StatelessWidget {
  PaymentSummaryScreen({Key? key}) : super(key: key);
  PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                    Spacer(),
                    Text(
                      "Dushyanta Gopivallabha",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black)),
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "9876543219",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blue),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "(38/male)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8E8E92)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "No previous medical history.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8E8E92)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 10,
                            offset: Offset(10, 10)),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.blue),
                        child: Image.asset(AppAsset.done),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Payment Summary",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                        decoration: BoxDecoration(
                            color: AppColor.grayBackground,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              "Enter today’s payment",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            Spacer(),
                            Text(
                              "Cash",
                              style: TextStyle(
                                  color: AppColor.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FlutterSwitch(
                              padding: 3,
                              toggleSize: 14,
                              activeColor: AppColor.blue,
                              width: 35.0,
                              height: 17.0,
                              value: paymentController.switchBoolValue.value,
                              borderRadius: 30.0,
                              onToggle: (bool value) {
                                paymentController.switchBoolValue.value = value;
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17, vertical: 20),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.grayBackground,
                              borderRadius: BorderRadius.circular(15)),
                          child: paymentFieldSheet()),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 16),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                        decoration: BoxDecoration(
                            color: AppColor.grayBackground,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              "Completed Payment",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff979797)),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff979797),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  emptyPaymentSheet() {
    return Column(
      children: [
        Text(
          "Payment done for ongoing treatment",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 18,
        ),
        Image.asset(
          AppAsset.patientEmpty,
          height: 80,
          width: 80,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Empty Sheet",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Track your payment history here,\nadd your first payment.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackText),
        )
      ],
    );
  }

  paymentFieldSheet() {
    return Column(
      children: [
        Text(
          "Payment done for ongoing treatment",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          margin: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2, 2))
          ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black),
                  ),
                  Text(
                    "8,100",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Received",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blue),
                  ),
                  Text(
                    "4,000",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blue),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Pending",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black),
                  ),
                  Text(
                    "-2,000",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColor.black),
                  )
                ],
              ),
            ],
          ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 12),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Text(
                  "28 July, 22",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Spacer(),
                Text(
                  "249",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue),
                )
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 5,
            );
          },
        ),
      ],
    );
  }
}
