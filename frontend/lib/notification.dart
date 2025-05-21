import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/text_template.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Notifications', style: headerblack),
        iconTheme: const IconThemeData(color: secondaryColor),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['title'] as String, style: headerblack2),
                  sizedbox1,
                  Text(notification['body'] as String, style: body1),
                  sizedbox2,
                  Text(notification['time'] as String, style: body1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Data notifikasi statis untuk keperluan UI
final List<Map<String, String>> _notifications = [
  {
    'title': 'New Message',
    'body': 'You have a new message from John Doe.',
    'time': '5 minutes ago',
  },
  {
    'title': 'Task Reminder',
    'body': 'Don\'t forget to complete your daily report.',
    'time': '30 minutes ago',
  },
  {
    'title': 'System Update',
    'body': 'A new version of the app is available. Update now!',
    'time': '1 hour ago',
  },
  {
    'title': 'Friend Request',
    'body': 'Jane Smith sent you a friend request.',
    'time': '2 hours ago',
  },
  {
    'title': 'Event Starting Soon',
    'body': 'The online workshop will begin in 15 minutes.',
    'time': 'Yesterday',
  },
];
