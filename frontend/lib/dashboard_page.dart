import 'package:flutter/material.dart';
import 'package:jam/colors.dart';

import 'notification_page.dart';

import 'calendar_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 30, // Increased size
                child: IconButton(
                  icon: const Icon(Icons.notifications_none, color: backgroundColor),
                  onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, right: 20, bottom: 25),
            child: CalendarWidget(),
          ),
          // You can add more widgets below if needed
        ],
      ),
    );
  }
}
