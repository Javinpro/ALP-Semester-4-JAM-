import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/method_management/timer_method/timer_metode5217.dart';
import 'package:jam/text_template.dart';

class Metode5217Page extends StatelessWidget {
  final String title;
  final String title2;
  final String imagePath;

  const Metode5217Page({
    super.key,
    required this.title,
    required this.title2,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(title, style: headerblack4),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
              bottom: 25.0,
            ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),

                // Tambahkan konten step disini.
                Text(
                  title2,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10.0),
                _buildStepText('1. Fokus pada satu tugas selama 52 menit.'),

                _buildStepText(
                  '2. Gunakan waktu istirahat 17 menit untuk meregangkan tubuh, minum air, atau melakukan aktivitas santai.',
                ),
                _buildStepText('3. Ulangi proses sampai tugas selesai.'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4, // Tambahkan efek bayangan
            ),
            onPressed: () {
              _showStartConfirmationModal(context, title); // Panggil modal
            },
            child: Text(
              'Mulai Sekarang',
              style: headerblack, // Gunakan style teks Anda
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: body2)),
        ],
      ),
    );
  }
}

Future<void> _showStartConfirmationModal(
  BuildContext context,
  String methodName,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // User bisa menutup modal dengan tap di luar
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          'Apakah kamu siap?',
          style: headerblack4,
          textAlign: TextAlign.center, // <--- Menengahkan judul
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                // <--- Memastikan konten utama di tengah
                child: Text(
                  'Dengan mengklik mulai, penghitung waktu metode ini akan secara otomatis dimulai',
                  style: headergrey2,
                  textAlign:
                      TextAlign.center, // <--- Menengahkan teks di dalam Center
                ),
              ),
              sizedbox4,
            ],
          ),
        ),
        actions: <Widget>[
          // Menggunakan Center atau Align untuk menengahkan tombol di bagian actions
          Center(
            // <--- Memastikan tombol di tengah
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0, // Lebar padding horizontal
                  vertical: 22.0, // Tinggi padding vertikal
                ),
                backgroundColor: primaryColor, // Warna tombol "Start Now!"
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup modal
                Navigator.pushReplacement(
                  // Navigasi ke halaman timer
                  context,
                  MaterialPageRoute(
                    // Pastikan Anda meneruskan `methodName` ke halaman timer
                    builder:
                        (context) =>
                            metode5217TimerPage(methodName: methodName),
                  ),
                );
              },
              child: const Text('Ayo mulai!', style: headerblack),
            ),
          ),
        ],
      );
    },
  );
}
