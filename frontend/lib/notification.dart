import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/text_template.dart';

/// Kelas data untuk merepresentasikan satu item notifikasi.
/// Ini akan membuat kode Anda lebih rapi dan mudah dikelola.
class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String text;

  const NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  // Contoh data notifikasi.
  // Anda bisa mendapatkan data ini dari API atau database di aplikasi nyata.
  final List<NotificationItem> notifications = const [
    NotificationItem(
      icon: Icons.error_outline,
      iconColor: orangeColor,
      text: 'Someone has answered Task Statistika.',
    ),
    NotificationItem(
      icon: Icons.check_circle_outlined,
      iconColor: greenColor,
      text: 'Answer Approved!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Notifikasi', style: headerblack4),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            // Mengambil item notifikasi berdasarkan indeks
            final notification = notifications[index];
            return Card(
              color: backgroundColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      notification.icon,
                      size: 40.0,
                      color: notification.iconColor,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(notification.text, style: headerblack),
                    ),
                  ],
                ),
              ),
            );
          },
          // Builder untuk pemisah antar item
          separatorBuilder: (context, index) => sizedbox1,
        ),
      ),
    );
  }
}
