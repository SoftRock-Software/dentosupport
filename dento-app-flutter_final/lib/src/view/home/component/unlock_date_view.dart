import 'package:flutter/material.dart';

import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';

unlockDateView() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AppAsset.unlockDate,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Text(
          "Out Of Clinic",
          style: TextStyle(
            color: AppColor.blue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 9,
          ),
          child: Text(
            "New Patients cannot be scheduled on this date. Unblock the date to schedule.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.navyGreyDarkBackground,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
