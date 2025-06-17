import 'package:flutter/material.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/colors.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryColor, // Customize border color
              width: 3.5, // Customize thickness
            ),
            color: Colors.transparent, // No fill
          ),
          defaultTextStyle: body3,
          weekendTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            // color: Colors.red,
          ),
          todayTextStyle: body3,
          selectedTextStyle: body3,
          outsideTextStyle: bodygrey,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: headerblack6,
          leftChevronIcon: Icon(Icons.chevron_left, size: 28),
          rightChevronIcon: Icon(Icons.chevron_right, size: 28),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: headerblack2,
          weekendStyle: headerblack2,
        ),
      ),
    );
  }
}
