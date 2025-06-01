import 'package:flutter/material.dart';
import 'package:jam/colors.dart';

import 'calendar_widget.dart';

class ActivityCalendarPage extends StatelessWidget {
  const ActivityCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Activity Calendar'),
      ),
      body: CalendarWidget(),
    );
  }
}
