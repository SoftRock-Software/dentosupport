import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/widgets/calendar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarListView extends StatefulWidget {
  const CalendarListView(
    this.dates, {
    super.key,
    this.onDateSelect,
    this.itemScrollController,
  });

  final List<VisitorCalendar> dates;
  final void Function(VisitorCalendar)? onDateSelect;
  final ItemScrollController? itemScrollController;

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  final _itemPositionsListener = ItemPositionsListener.create();

  static const decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: boxShadow,
  );

  static const clinicOffDecoration = BoxDecoration(
    color: Color(0xFFE6E6E6),
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: boxShadow,
  );

  static const clinicOffStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColor.subtitleColor,
    decoration: TextDecoration.lineThrough,
  );

  static const style = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColor.textColor,
  );

  static const boxShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.09),
      blurRadius: 4,
      offset: Offset(0, 2),
    )
  ];

  static const todayDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: boxShadow,
  );

  static const todayStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.white,
  );

  static const selectDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: boxShadow,
    border: Border(
      top: BorderSide(color: AppColor.primaryColor),
      bottom: BorderSide(color: AppColor.primaryColor),
      right: BorderSide(color: AppColor.primaryColor),
      left: BorderSide(color: AppColor.primaryColor),
    ),
  );

  static const selectStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColor.primaryColor,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.dates.isEmpty) {
      return const SizedBox(
        height: 84,
        width: double.infinity,
      );
    }

    return SizedBox(
      height: 84,
      width: double.infinity,
      child: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemScrollController: widget.itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.dates.length,
            itemBuilder: (context, index) {
              final date = widget.dates[index];

              final today = date.day == DateTime.now().day.toString();

              var fDecoration = decoration;
              var fStyle = style;

              if (today) {
                fDecoration = todayDecoration;
                fStyle = todayStyle;
              } else if (date.dayOff) {
                fDecoration = clinicOffDecoration;
                fStyle = clinicOffStyle;
              } else if (date.selected) {
                fDecoration = selectDecoration;
                fStyle = selectStyle;
              }

              return GestureDetector(
                onTap: () {
                  _onDateSelection(date);
                },
                child: CalendarItemWidget(
                  weekDay: date.weekDay,
                  date: date.day,
                  badge: date.dateTime.isToday ? null : date.badge,
                  decoration: fDecoration,
                  style: fStyle,
                  badgeColor:
                      date.feature ? AppColor.primaryColor : AppColor.red,
                ),
              );
            },
          ),
          if (widget.itemScrollController != null) positionsView,
        ],
      ),
    );
  }

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: _itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? min;
          int? max;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce(
                  (ItemPosition min, ItemPosition position) =>
                      position.itemTrailingEdge < min.itemTrailingEdge
                          ? position
                          : min,
                )
                .index;
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            max = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce(
                  (ItemPosition max, ItemPosition position) =>
                      position.itemLeadingEdge > max.itemLeadingEdge
                          ? position
                          : max,
                )
                .index;
          }

          if (widget.dates.isEmpty) {
            return const SizedBox();
          }

          if ((min ?? 0) >= 14) {
            final date = widget.dates[14];

            return Positioned(
              left: -10,
              child: SizedBox(
                height: 84,
                child: GestureDetector(
                  onTap: () {
                    _onDateSelection(date);
                  },
                  child: CalendarItemWidget(
                    weekDay: date.weekDay,
                    date: date.day,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: boxShadow,
                    ),
                    style: todayStyle,
                  ),
                ),
              ),
            );
          }

          if ((max ?? 0) <= 14) {
            final date = widget.dates[14];

            return Positioned(
              right: -10,
              child: SizedBox(
                height: 84,
                child: GestureDetector(
                  onTap: () {
                    _onDateSelection(date);
                  },
                  child: CalendarItemWidget(
                    weekDay: date.weekDay,
                    date: date.day,
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      boxShadow: boxShadow,
                    ),
                    style: todayStyle,
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      );

  void _onDateSelection(VisitorCalendar date) {
    widget.onDateSelect?.call(date);
  }
}
