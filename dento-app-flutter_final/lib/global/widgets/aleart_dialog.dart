import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

commonAlertDialog({
  String? title = "Error",
  String? description = "",
  String? cancelText = "No",
  String? confirmText = "Yes",
  Function? onConfirm,
  Function? onCancel,
  bool? willPopScope,
}) {
  return Get.defaultDialog(
    barrierDismissible: false,
    title: title!,
    content: WillPopScope(
      onWillPop: () async {
        return willPopScope ?? true;
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          // top: 8,
          bottom: 8,
        ),
        child: Text(
          description!,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    contentPadding: const EdgeInsets.only(
      bottom: 16,
      top: 8,
    ),
    buttonColor: AppColor.blue,
    textConfirm: confirmText,
    confirmTextColor: AppColor.white,
    onConfirm: onConfirm as void Function()?,
    cancelTextColor: AppColor.blue,
    textCancel: cancelText,
    onCancel: onCancel as void Function()? ??
        () {
          Get.back();
        },
  );
}
