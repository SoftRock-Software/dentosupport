import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = AppColor.primaryColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColor.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
