import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/notification.dart'; // Make sure this path is correct for your color definitions

class MethodPage extends StatelessWidget {
  const MethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          backgroundColor, // Using the background color from your imported file
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Making the app bar transparent
        elevation: 0, // Removing the shadow
        title: const Text(
          "Methods", // Title for the app bar
          style: TextStyle(
            color: Colors.white, // Adjust text color as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // Align title to the left
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ), // Replace with your EditProfilePage widget
                );
              },

              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white, // Circle background color
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.notifications,
                  color: Colors.black, // Notification icon color
                  size: 24.0,
                ),
              ),
            ),
          ),
        ],
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
                  color: Colors.white.withOpacity(
                    0.2,
                  ), // Slightly transparent white
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.white70),
                  ),
                ),
              ),
              // --- Cards ---
              _buildMethodCard(
                context,
                imagePath:
                    'assets/images/method_1.png', // Replace with your image path
                title: 'Deep Breathing',
                description:
                    'Relax and reduce stress with guided deep breathing exercises.',
              ),
              const SizedBox(height: 16.0),
              _buildMethodCard(
                context,
                imagePath:
                    'assets/images/method_2.png', // Replace with your image path
                title: 'Mindful Meditation',
                description:
                    'Cultivate presence and inner peace through mindful awareness.',
              ),
              const SizedBox(height: 16.0),
              _buildMethodCard(
                context,
                imagePath:
                    'assets/images/method_3.png', // Replace with your image path
                title: 'Progressive Muscle Relaxation',
                description:
                    'Ease tension by tensing and relaxing different muscle groups.',
              ),
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
              child: ElevatedButton(
                onPressed: () {
                  // Handle "Start" button tap
                  print("Start button tapped for: $title");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Start",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
