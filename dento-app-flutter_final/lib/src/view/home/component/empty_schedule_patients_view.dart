import 'package:flutter/material.dart';

import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_string.dart';

emptyScheduelView() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AppAsset.emptyScheduel,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Text(
          "Schedule Patients",
          style: TextStyle(
            color: AppColor.darkBlackText,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 9,
          ),
          child: Text(
            "Schedule missed patients using Schedule button OR use search to schedule.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.navyGreyDarkBackground,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.only(top: 2, bottom: 15, left: 60, right: 60),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Text(
                "Mark as",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffADB3BC)),
              ),
              Text(
                "Out Of Clinic",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
