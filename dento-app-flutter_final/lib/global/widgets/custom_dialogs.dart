// Common Dialogs

import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogs {
  void showCircularDialog(
    BuildContext context,
  ) {
    CircularDialog.showLoadingDialog(
      context,
    );
  }

  void hideCircularDialog(
    BuildContext context,
  ) {
    Navigator.pop(
      context,
    );
  }

  Future getDialog({
    String title = "Error",
    String desc = "",
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      titleStyle: TextStyle(
        color: AppColor.blue,
      ),
      content: Text(
        desc,
        textAlign: TextAlign.center,
      ),
      buttonColor: AppColor.blue,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  getUserAvailableDialog({
    String title = "Error",
    String email = "",
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      titleStyle: TextStyle(
        color: AppColor.blue,
      ),
      content: Text(
        "this mobile number attech with $email",
        textAlign: TextAlign.center,
      ),
      buttonColor: AppColor.blue,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  getAccountAlreadyExistDialog({
    String title = "Error",
    String email = "",
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      titleStyle: TextStyle(
        color: AppColor.blue,
      ),
      content: Text(
        "this mobile number attech with $email",
        textAlign: TextAlign.center,
      ),
      buttonColor: AppColor.blue,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}

class CircularDialog {
  static Future<void> showLoadingDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      barrierColor: AppColor.transparent,
      builder: (
        BuildContext context,
      ) {
        return WillPopScope(
          child: Center(
            child: CircularProgressIndicator(
              color: AppColor.black,
            ),
          ),
          onWillPop: () async {
            return false;
          },
        );
      },
      barrierDismissible: false,
    );
  }
}

class CircularDialogWithoutDismiss {
  static Future<void> showLoadingDialog(
      BuildContext context,
      ) {
    return showDialog(
      context: context,
      barrierColor: AppColor.transparent,
      builder: (
          BuildContext context,
          ) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.blue,
          ),
        );
      },
      barrierDismissible: false,
    );
  }
}