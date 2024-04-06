import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget(this.empty, {super.key});

  final Empty empty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Image.asset(
          empty.image,
          height: 150,
        ),
        const SizedBox(height: 15),
        Text(
          empty.title,
          style: const TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColor.primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            empty.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColor.textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class Empty {
  const Empty({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  /// Today empty list view
  static const today = Empty(
    image: AppAssets.empty,
    title: 'Get Started!',
    description: 'Start with adding new patient first.',
  );

  /// Today & Off day, empty list view
  static const todayOff = Empty(
    image: AppAssets.todayAndOff,
    title: 'Out Of Clinic',
    description:
        'This is your chance to unwind and take a moment for yourself.',
  );

  /// Yesterday empty list view
  static const yesterday = Empty(
    image: AppAssets.yesterday,
    title: 'No Previous Patients',
    description: '',
  );

  /// Tomorrow empty list view
  static const tomorrow = Empty(
    image: AppAssets.tomorrow,
    title: 'Schedule Patients',
    description: 'Schedule missed or existing patients.',
  );

  /// Bolcked date empty list view
  static const bolcked = Empty(
    image: AppAssets.bolcked,
    title: 'Out Of Clinic',
    description: '''
New Patients cannot be scheduled on this date. Unblock the date to schedule.''',
  );
}
