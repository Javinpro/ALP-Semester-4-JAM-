import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';

import 'notification.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/chart_widget.dart';

import '../widgets/activitycalendar_page.dart'; // for testing
import 'progresstracker_page.dart'; // for testing

// reference for bar chart
// int bar_1 = 7;
// int bar_2 = 4;
// int bar_3 = 14;
// int bar_4 = 2;
// int bar_5 = 1;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> completedTasks = [bar_1, bar_2, bar_3, bar_4, bar_5];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text('Dashboard', style: headerblack4),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 30,
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: backgroundColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                top: 10,
                right: 20,
                bottom: 25,
              ),
              child: CalendarWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Text('This Month', style: body5),
                    ),
                  ),
                  WeeklyCompletionBarChart(completedTasks: completedTasks),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/img/maketodo.png',
                          height: 60,
                          // width: 30,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Make To Do',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              ),
                              // SizedBox(height: 4),
                              // Text(
                              //   'Select a task to make to do.',
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: secondaryColor
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 200), // mitigasi bottom navbar
                  // TESTING AREA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityCalendarPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Go to Activity Calendar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProgressTrackerPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Go to progress tracker',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
