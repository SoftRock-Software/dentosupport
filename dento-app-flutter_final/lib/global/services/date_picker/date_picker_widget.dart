import 'package:Dentosupport_mini/global/services/date_picker/date_widget.dart';
import 'package:Dentosupport_mini/global/services/date_picker/extra/color.dart';
import 'package:Dentosupport_mini/global/services/date_picker/extra/style.dart';
import 'package:Dentosupport_mini/global/services/date_picker/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class DatePicker extends StatefulWidget {
  final DateTime startDate;

  final double width;

  final double height;

  final DatePickerController? controller;

  final Color selectedTextColor;

  final Color selectionColor;

  final Color deactivatedColor;

  final TextStyle monthTextStyle;

  final TextStyle dayTextStyle;

  final TextStyle dateTextStyle;

  final DateTime? /*?*/ initialSelectedDate;

  final List<DateTime>? inactiveDates;

  final List<DateTime>? activeDates;

  final DateChangeListener? onDateChange;

  final int daysCount;

  final String locale;

  DatePicker(
    this.startDate, {
    Key? key,
    this.width = 60,
    this.height = 73,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _currentDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  @override
  void initState() {
    debugPrint("-=--=-=-${widget.inactiveDates}");
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }

    selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (
          context,
          index,
        ) {
          DateTime date;
          DateTime _date = widget.startDate.add(
            Duration(
              days: index,
            ),
          );
          date = DateTime(
            _date.year,
            _date.month,
            _date.day,
          );

          bool isDeactivated = false;

          if (widget.inactiveDates != null) {
//            print("Inside Inactive dates.");
            for (DateTime inactiveDate in widget.inactiveDates!) {
              if (_compareDate(date, inactiveDate)) {
                isDeactivated = true;
                break;
              }
            }
          }

          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activateDate in widget.activeDates!) {
              // Compare the date if it is in the
              if (_compareDate(date, activateDate)) {
                isDeactivated = false;
                break;
              }
            }
          }

          bool isSelected =
              _currentDate != null ? _compareDate(date, _currentDate!) : false;

          return DateWidget(
            date: date,
            inactiveDate: widget.inactiveDates!.isNotEmpty &&
                    date.toString().split(" ").first ==
                        widget.inactiveDates![0].toString().split(" ").first
                ? true
                : false,
            monthTextStyle: isDeactivated
                ? deactivatedMonthStyle
                : isSelected
                    ? selectedMonthStyle
                    : widget.monthTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected
                    ? selectedDateStyle
                    : widget.dateTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected
                    ? selectedDayStyle
                    : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor: isSelected ? widget.selectionColor : Colors.white,
            onDateSelected: (selectedDate) {
              if (isDeactivated) return;
              if (widget.onDateChange != null) {
                widget.onDateChange!(selectedDate);
              }
              setState(
                () {
                  _currentDate = selectedDate;
                },
              );
            },
          );
        },
      ),
    );
  }

  bool _compareDate(
    DateTime date1,
    DateTime date2,
  ) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState? _datePickerState;

  void setDatePickerState(
    _DatePickerState state,
  ) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
      _datePickerState!.widget.startDate.year,
      _datePickerState!.widget.startDate.month,
      _datePickerState!.widget.startDate.day,
    );

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
