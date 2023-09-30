// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/color_constants.dart';

class CustomCalendar extends StatefulWidget {
  CalendarFormat calendarFormat;
  DateTime currentDay;
  DateTime? selectedDay;
  StateSetter setState;
  Function actionToPerform;

  CustomCalendar({
    Key? key,
    required this.calendarFormat,
    required this.currentDay,
    required this.selectedDay,
    required this.setState,
    required this.actionToPerform,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2100, 3, 14),
      focusedDay: widget.currentDay,
      currentDay: widget.currentDay,
      rowHeight: 32,
      calendarFormat: widget.calendarFormat,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronPadding: EdgeInsets.zero,
        leftChevronMargin: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
        titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.gray900,
            fontFamily: "Metropolis"),
      ),
      daysOfWeekHeight: 24,
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: "Metropolis",
          color: ColorConstants.colorFromHex("#0E1339"),
        ),
        weekendStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w500,
          color: ColorConstants.colorFromHex("#0E1339"),
        ),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w600,
          color: ColorConstants.primary,
        ),
        withinRangeDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.colorFromHex("#F4F5FB"),
        ),
        defaultTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w600,
          color: ColorConstants.colorFromHex("#34405E"),
        ),
        outsideTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w600,
          color: ColorConstants.colorFromHex("#AEB2BF"),
        ),
        weekendTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w600,
          color: ColorConstants.colorFromHex("#34405E"),
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.colorFromHex("#F4F5FB"),
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.colorFromHex("#F4F5FB"),
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.primaryLight,
        ),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.primary,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis",
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ), //
      ),
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDay, day);
      },
      onDaySelected: (selectedDay, currentDay) {
        if (selectedDay.isBefore(DateTime.now())) {
          Get.snackbar(
            "Error",
            "Selected day cannot be in the past",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: ColorConstants.white,
            colorText: ColorConstants.black,
          );
        } else if (!isSameDay(selectedDay, selectedDay)) {
          debugPrint("selectedDay");
          widget.setState(() {
            selectedDay = selectedDay;
            widget.actionToPerform;
          });
        }
      },
      onFormatChanged: (format) {
        if (widget.calendarFormat != format) {
          widget.setState(() {
            widget.calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {},
    );
  }
}
