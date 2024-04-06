import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';

import 'common_name_dot_colum.dart';

todayView() {
  return Expanded(
    child: ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 33),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            commonNameColum(
                dotColor: AppColor.blue,
                name: "Renuka Kulkarni",
                clinicName: "No Active Treatment",
                clinicNameColor: AppColor.blue),
            const Spacer(),
            const Text(
              "-400",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff555555)),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff555555),
              size: 11,
            )
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
