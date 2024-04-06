import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/src/view/patientview/view/patient_screen.dart';
import 'package:Dentosupport_mini/src/view/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSubscriptionScreen extends StatelessWidget {
  const PaymentSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.blue,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Payment & Subscription",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: AppColor.blue),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 21, vertical: 32),
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 13),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      spreadRadius: 1,
                      offset: Offset(0.5, 1))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment History",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                ListView.separated(
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
                SizedBox(
                  height: 18,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    width: 66,
                    decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Help",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 21),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 19),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                  spreadRadius: 1,
                  offset: Offset(0.5, 1))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage Subscription",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium User",
                          style: TextStyle(
                              color: AppColor.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Expires on March 22, 2022",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(() => PatientScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 66,
                        decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
