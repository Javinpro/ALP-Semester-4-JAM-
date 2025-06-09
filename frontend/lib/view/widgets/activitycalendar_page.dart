import 'package:flutter/material.dart';
import 'package:jam/view/widgets/colors.dart';
import 'calendar_widget.dart';
import '../pages/status_card.dart'; // <- import the new file

class ActivityCalendarPage extends StatelessWidget {
  const ActivityCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          'Calendar',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CalendarWidget(),
          const SizedBox(height: 24),
          const Text(
            'Status',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          StatusCard(title: 'Statistika', date: '06 - 7 - 2025', time: '00.00'),
          StatusCard(title: 'Kalkulus', date: '28 - 4 - 2025', time: '00.00'),
          StatusCard(
            title: 'Bhs. Inggris',
            date: '26 - 4 - 2025',
            time: '00.00',
          ),
          StatusCard(title: 'Matrix', date: '25 - 4 - 2025', time: '00.00'),
        ],
      ),
    );
  }
}
