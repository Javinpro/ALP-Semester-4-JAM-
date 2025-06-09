import 'package:flutter/material.dart';
import 'package:jam/view/widgets/colors.dart';
import 'package:jam/view/pages/method_management/detail_method/Metode_52-17.dart';
import 'package:jam/view/pages/method_management/detail_method/Ultradian_Rhythm.dart';
import 'package:jam/view/pages/method_management/detail_method/pomodoro.dart';
import 'package:jam/view/pages/notification.dart';
import 'package:jam/view/widgets/text_template.dart'; // Make sure this path is correct for your color definitions

class MethodPage extends StatefulWidget {
  const MethodPage({super.key});

  @override
  State<MethodPage> createState() => _MethodPageState();
}

class _MethodPageState extends State<MethodPage> {
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // --- Search Bar ---
              Container(
                margin: const EdgeInsets.only(bottom: 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: backgroundColor, // Slightly transparent white
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor.withOpacity(0.3),
                      spreadRadius: 0, // Seberapa jauh bayangan menyebar
                      blurRadius: 6, // Seberapa buram bayangan
                      offset: const Offset(0, 3), // Pergeseran bayangan (x, y)
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(color: secondaryColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                    hintText: "Search method...",
                    hintStyle: headergrey,
                    border: InputBorder.none,
                    icon: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search, color: primaryColor),
                    ),
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
                detailPage: const PomodoroDetailPage(
                  title: 'Pomodoro',
                  title2: 'Langkah Metode : ',
                  imagePath: 'assets/img/Pomodoro.jpg',
                ),
              ),
              sizedbox11,
              _buildMethodCard(
                context,
                imagePath:
                    'assets/img/Metode 5217.jpg', // Replace with your image path
                title: 'Metode 52/17',
                description:
                    'Fokus pada pekerjaan selama 52 menit, diikuti dengan istirahat selama 17 menit.',
                detailPage: const Metode5217Page(
                  title: 'Metode 52/17',
                  title2: 'Langkah Metode : ',
                  imagePath: 'assets/img/Metode 5217.jpg',
                ),
              ),
              sizedbox11,
              _buildMethodCard(
                context,
                imagePath:
                    'assets/img/Ultradian Rhythm.jpg', // Replace with your image path
                title: 'Ultradian Rhythm',
                description:
                    'Fokus pada pekerjaan intensif selama 90 menit, diikuti dengan istirahat selama 30 menit.',
                detailPage: const UltradianRhythmPage(
                  title: 'Ultradian Rhythm',
                  title2: 'Langkah Metode : ',
                  imagePath: 'assets/img/Ultradian Rhythm.jpg',
                ),
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
    required Widget detailPage,
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
                    elevation: 4, // Tambahkan efek bayangan
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => detailPage),
                    );
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
