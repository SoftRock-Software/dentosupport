import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class CalendarItemWidget extends StatelessWidget {
  const CalendarItemWidget({
    super.key,
    required this.weekDay,
    required this.date,
    required this.decoration,
    required this.style,
    this.badge,
    this.badgeColor = AppColor.red,
  });

  final String weekDay;
  final String date;
  final int? badge;
  final BoxDecoration decoration;
  final TextStyle style;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(14),
          decoration: decoration,
          child: Column(
            children: [
              Text(
                weekDay,
                style: style,
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: style,
              ),
            ],
          ),
        ),
        if (badge != null)
          Positioned(
            right: 0,
            top: 3,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  badge.toString(),
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColor.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
