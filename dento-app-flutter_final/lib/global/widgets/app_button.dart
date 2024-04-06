import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.buttonTextColor,
    this.titleBold,
    this.fontWeight,
    this.lcPadding,
    this.tcPadding,
    this.rcPadding,
    this.bcPadding,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  Color? buttonColor;
  Color? buttonTextColor;
  bool? titleBold;
  FontWeight? fontWeight;
  double? lcPadding;
  double? tcPadding;
  double? rcPadding;
  double? bcPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColor.blue,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: lcPadding ?? 49,
                top: tcPadding ?? 12,
                right: rcPadding ?? 49,
                bottom: bcPadding ?? 12,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: buttonTextColor ?? Colors.white,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
