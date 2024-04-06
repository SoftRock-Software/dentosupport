import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gestures/tap.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final bool inactiveDate;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
    this.inactiveDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: const EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          top: 4,
          bottom: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
          // color: selectionColor,
          boxShadow: kElevationToShadow[2],
          color:
              inactiveDate == true ? AppColor.greyBackground : selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /*Text(new DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                  style: monthTextStyle),*/
              Text(
                DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                style: inactiveDate == true
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColor.darkGreyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )
                    : dayTextStyle, /*const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColor.white,
                ),*/
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                date.day.toString(), // Date
                // style: dateTextStyle,
                style: inactiveDate == true
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColor.darkGreyText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )
                    : dateTextStyle, /*const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.white,
                ),*/
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print("-=-=-=-=--${onDateSelected}");
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
