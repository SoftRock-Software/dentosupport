import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
  });

  final String name;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Dr. $name',
          style: const TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: AppColor.textColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          phoneNumber,
          style: const TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColor.subtitleColor,
          ),
        ),
      ],
    );
  }
}
