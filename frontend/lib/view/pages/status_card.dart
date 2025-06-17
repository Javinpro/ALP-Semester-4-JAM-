// lib/view/widgets/status_card.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final Color? cardColor; // <-- Tambahkan properti ini
  final Color? borderColor; // <-- Tambahkan properti ini

  const StatusCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    this.cardColor, // <-- Jadikan opsional
    this.borderColor, // <-- Jadikan opsional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // bottom spacing between cards
      child: Card(
        elevation: 2,
        color: cardColor ?? backgroundColor, // Gunakan cardColor atau default
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 2,
          ), // Gunakan borderColor atau default
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'Poppins', // Pastikan font Poppins tersedia
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: orangeColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '|',
                    style: TextStyle(
                      color: orangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: orangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
