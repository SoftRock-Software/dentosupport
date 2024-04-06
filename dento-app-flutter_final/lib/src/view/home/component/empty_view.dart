import 'package:flutter/material.dart';

import '../../../../global/constants/app_asset.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/app_string.dart';

emptyHomePageView() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AppAsset.homeScreen,
            height: 184.66,
            width: 247.8,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        const Text(
          AppString.getStarted,
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
            top: 20,
          ),
          child: Text(
            AppString.startWithAddingNewPatientFirst,
            style: TextStyle(
              color: AppColor.navyGreyDarkBackground,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
