import 'package:flutter/material.dart';

import '../../../../global/constants/app_color.dart';
import 'common_name_dot_colum.dart';

pastDayView() {
  return Expanded(
    child: ListView.separated(
      padding: const EdgeInsets.only(top: 33, bottom: 33, left: 8, right: 8),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            commonNameColum(
                nameColor: AppColor.red,
                clinicNameColor: Colors.black,
                name: "Rajesh Joshi",
                clinicName: "RCT"),
            const Spacer(),
            const Text(
              "-400",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 25,
          color: Color(0xffD4D4D4),
        );
      },
    ),
  );
}
