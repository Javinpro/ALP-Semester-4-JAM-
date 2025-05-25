import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/notification.dart';
import 'package:jam/text_template.dart'; // Make sure this path is correct for your color definitions

class MethodPage extends StatelessWidget {
  const MethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          backgroundColor, // Using the background color from your imported file
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: const Text('Method Page', style: headerblack4),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0, top: 10.0),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 30, // Increased size
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // --- Search Bar ---
              Container(
                margin: const EdgeInsets.only(bottom: 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: backgroundColor, // Slightly transparent white
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const TextField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: secondaryColor),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: secondaryColor),
                  ),
                ),
              ),
              // --- Cards ---
              _buildMethodCard(
                context,
                imagePath:
                    'assets/img/Pomodoro.jpg', // Replace with your image path
                title: 'Pomodoro',
                description:
                    'Membagi pekerjaan menjadi interval 25 menit yang dipisahkan oleh istirahat singkat 10 menit.',
              ),
              sizedbox11,
              _buildMethodCard(
                context,
                imagePath:
                    'assets/img/Metode 5217.jpg', // Replace with your image path
                title: 'Metode 52/17',
                description:
                    'Fokus pada pekerjaan selama 52 menit, diikuti dengan istirahat selama 17 menit.',
              ),
              sizedbox11,
              _buildMethodCard(
                context,
                imagePath:
                    'assets/img/Ultradian Rhythm.jpg', // Replace with your image path
                title: 'Ultradian Rhythm',
                description:
                    'Fokus pada pekerjaan intensif selama 90 menit, diikuti dengan istirahat selama 20 menit.',
              ),
              sizedbox10,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.white, // Card background color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditProfilePage(),
                    //   ), // Replace with your EditProfilePage widget
                    // );
                  },
                  child: const Text('Start', style: headerblack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
