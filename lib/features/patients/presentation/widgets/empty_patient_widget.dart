import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class EmptyPatientWidget extends StatelessWidget {
  const EmptyPatientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Image.asset(
          AppAssets.emptySheetPng,
          height: 166,
        ),
        const SizedBox(height: 15),
        const Text(
          'Empty Sheet',
          style: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            'No records to show here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF7A7A7A),
            ),
          ),
        ),
      ],
    );
  }
}
