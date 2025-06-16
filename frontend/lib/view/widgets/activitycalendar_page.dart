import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';
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
        scrolledUnderElevation: 0,

        title: const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.3),
                  spreadRadius: 0, // Seberapa jauh bayangan menyebar
                  blurRadius: 6, // Seberapa buram bayangan
                  offset: const Offset(0, 3), // Pergeseran bayangan (x, y)
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: secondaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CalendarWidget(),
          const SizedBox(height: 24),
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
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
