import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';

void showScheduleSheet(
  BuildContext context, {
  void Function()? onSchedule,
  void Function()? onCancel,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFAAAAAA),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '''
This date is marked as dentist is out of clinic.''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor.red,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                '''
Unblocking this date will let you schedule patients on this date.''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xFF1A202C),
                ),
              ),
            ),
            const SizedBox(height: 30),
            AppPrimaryButton(
              title: 'Unblock & Schedule',
              onPressed: () {
                Navigator.pop(context);
                onSchedule?.call();
              },
            ),
            const SizedBox(height: 20),
            AppPrimaryButton(
              title: 'Cancel',
              backgroundColor: AppColor.red,
              onPressed: () {
                Navigator.pop(context);
                onCancel?.call();
              },
            ),
          ],
        ),
      );
    },
  );
}
