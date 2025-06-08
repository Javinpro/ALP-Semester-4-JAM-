import 'package:flutter/material.dart';
import 'package:jam/colors.dart';

import 'chart_widget.dart';
import 'status_card.dart';

class ProgressTrackerPage extends StatelessWidget {
  const ProgressTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> completedTasks = [bar_1, bar_2, bar_3, bar_4, bar_5];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          'Your Progress',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'This Month',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 20),
      WeeklyCompletionBarChart(completedTasks: completedTasks),
      const SizedBox(height: 24),
      const Text(
        'Week 1',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const StatusCard(
        title: 'Pemrograman Web',
        date: '03 - 6 - 2025',
        time: '10.00',
      ),
      const Text(
        'Week 2',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const StatusCard(
        title: 'Struktur Data',
        date: '04 - 6 - 2025',
        time: '12.00',
      ),
      const Text(
        'Week 3',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const StatusCard(
        title: 'Sistem Operasi',
        date: '05 - 6 - 2025',
        time: '14.00',
      ),
      const Text(
        'Week 4',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const StatusCard(
        title: 'Kalkulus Lanjut',
        date: '06 - 6 - 2025',
        time: '09.00',
      ),
    ],
  ),
),

    );
  }
}
