// lib/view/pages/posting_task/task_detail_page.dart
import 'package:flutter/material.dart';
import 'package:jam/models/task.dart'; // Import model Task
import 'package:jam/view/pages/posting_task/dummy_task_card.dart';
import 'package:jam/view/utils/colors.dart'; // Asumsi colors.dart ada
import 'package:jam/view/utils/text_template.dart'; // Asumsi text_template.dart ada

class TaskDetailPage extends StatelessWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text('Detail Unggahan', style: headerblack3), // Ubah judul
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.taskName, style: headerblack),
            sizedbox1, // Asumsi sizedbox1 = SizedBox(height: 8)
            sizedbox1,
            if (task.difficulty != null)
              Chip(
                label: Text(
                  'Kesulitan: ${task.difficulty!.name}',
                  style: body2,
                ),
                backgroundColor: secondaryColor.withOpacity(0.2),
              ),
            sizedbox1,
            Text(
              'Deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year} - ${task.deadline.hour.toString().padLeft(2, '0')}:${task.deadline.minute.toString().padLeft(2, '0')}',
              style: body1.copyWith(fontWeight: FontWeight.w500),
            ),
            sizedbox11, // Asumsi sizedbox11 = SizedBox(height: 11)
            Text('Deskripsi:', style: headerblack2),
            sizedbox1,
            Text(
              task.description ??
                  'Tidak ada deskripsi lengkap untuk tugas ini.',
              style: body1,
            ),
            sizedbox11,
            if (task.photoPath != null && task.photoPath!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gambar Tugas:', style: headerblack2),
                  sizedbox1,
                  // Ini hanya contoh, Anda perlu memastikan path foto benar dan aset sudah ditambahkan di pubspec.yaml
                  // Jika foto dari internet, gunakan Image.network()
                  Image.asset(
                    task.photoPath!,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Text('Gambar tidak dapat dimuat.'),
                  ),
                ],
              ),
            sizedbox11,
            if (task.assignedToUserId != null)
              Text(
                'Tugas ini sudah ditugaskan kepada: ${task.assignedToUserId == currentLoggedInUserId ? "Anda" : "User lain (ID: ${task.assignedToUserId})"}',
                style: body1.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                ),
              ),
            // Tambahkan tombol atau aksi lain yang relevan di halaman detail
            sizedbox11,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk "Ambil Tugas Ini" atau aksi lain
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Anda mencoba mengambil tugas: ${task.taskName}',
                      ),
                    ),
                  );
                  // Misalnya, Anda bisa memanggil ViewModel untuk meng-assign tugas ini ke current user
                  // Atau kembali ke halaman sebelumnya setelah aksi
                  // Navigator.pop(context);
                },
                child: Text('Unggah', style: headerblack),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: secondaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
