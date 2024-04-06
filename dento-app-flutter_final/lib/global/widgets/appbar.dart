// AppBar

import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:flutter/material.dart';

AppBar appBar({
  String? titleName,
  Function()? onTap,
  Color? backgroundColor,
  isIcon = false,
  Widget? actionWidget,
  textColor,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: backgroundColor ?? AppColor.white,
    automaticallyImplyLeading: false,
    /*leadingWidth: 45,
    leading: InkWell(
      onTap: onTap!,
      child: Icon(
        Icons.arrow_back,
        color: textColor ?? AppColor.black,
      ),
    ),*/
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          AppString.dento,
          style: TextStyle(
            color: AppColor.blue,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          AppString.support,
          style: TextStyle(
            color: AppColor.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
    centerTitle: false,
    actions: [
      isIcon ? actionWidget! : const SizedBox(),
    ],
    // elevation: 0.0,
  );
}
