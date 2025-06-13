// view/pages/method_management/detail_method/pomodoro.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Tambahkan ini
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/pages/method_management/timer_method/timer_podomoro.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/method.dart';
import 'package:jam/viewmodels/pomodoro_timer_viewmodel.dart'; // Import ViewModel

class PomodoroDetailPage extends StatelessWidget {
  final String title;
  final String title2;
  final String title3;
  final String imagePath;

  const PomodoroDetailPage({
    super.key,
    required this.title,
    required this.title2,
    required this.title3,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(
      context,
    ).textScaler.scale(1.0); // Dapatkan faktor skala teks

    final method = Method.defaultMethods.firstWhere((m) => m.title == title);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          title,
          style: headerblack4.copyWith(
            fontSize:
                headerblack4.fontSize! *
                textScaleFactor, // Skalakan font judul AppBar
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.015), // Responsif padding
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(
                screenWidth * 0.025,
              ), // Responsif border radius
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.3),
                  spreadRadius: screenWidth * 0.00,
                  blurRadius: screenWidth * 0.015,
                  offset: Offset(0, screenWidth * 0.0075),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: secondaryColor,
                size: screenWidth * 0.06, // Responsif ukuran icon
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Column(
        // Ubah body menjadi Column
        children: [
          Expanded(
            // Bungkus SingleChildScrollView dengan Expanded
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.05), // Responsif padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        screenWidth * 0.025,
                      ), // Responsif border radius
                      child: Image.asset(
                        imagePath,
                        width: screenWidth * 0.9, // Responsif lebar gambar
                        height: screenHeight * 0.25, // Responsif tinggi gambar
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                              Icons.error,
                              size: screenWidth * 0.35,
                            ), // Responsif ukuran icon error
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ), // Responsif tinggi SizedBox (dulu 20)
                  Text(
                    title3,
                    style: headerblack.copyWith(
                      fontSize:
                          headerblack.fontSize! *
                          textScaleFactor, // Skalakan font
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ), // Responsif tinggi SizedBox (dulu sizedbox5)
                  Text(
                    method.description,
                    style: body2.copyWith(
                      color: Colors.black87,
                      fontSize:
                          body2.fontSize! * textScaleFactor, // Skalakan font
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.03), // Hapus SizedBox ini jika tidak diperlukan di sini (dulu sizedbox4)
                ],
              ),
            ),
          ),
          // Tempatkan tombol di luar SingleChildScrollView, di bagian bawah Column utama
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ), // Tambahkan padding untuk tombol
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.07, // Responsif tinggi tombol
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth * 0.04,
                    ), // Responsif border radius tombol
                  ),
                  elevation: screenWidth * 0.02, // Responsif elevation
                ),
                onPressed:
                    () => _showStartConfirmationDialog(context, method.id),
                child: Text(
                  'Coba deh!',
                  style: headerblack.copyWith(
                    fontSize:
                        headerblack.fontSize! *
                        textScaleFactor, // Skalakan font tombol
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStartConfirmationDialog(BuildContext context, String methodName) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaler.scale(1.0);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          title: Text(
            'Betulan nih mau mulai ${title}?',
            style: headerblack3.copyWith(
              fontSize: headerblack3.fontSize! * textScaleFactor,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Setelah kamu klik tombol dibawah, timernya akan secara otomatis berjalan...',
                style: body2.copyWith(
                  fontSize: body2.fontSize! * textScaleFactor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
          actions: <Widget>[
            Center(
              child: Consumer(
                // Tambahkan Consumer untuk mengakses Riverpod
                builder: (context, ref, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.12,
                        vertical: screenHeight * 0.02,
                      ),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.025,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      // Panggil startTimer dari ViewModel
                      ref
                          .read(
                            pomodoroTimerViewModelProvider(methodName).notifier,
                          )
                          .startTimer();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PomodoroTimerPage(methodId: methodName),
                        ),
                      );
                    },
                    child: Text(
                      'Iyaa!',
                      style: headerblack.copyWith(
                        fontSize: headerblack.fontSize! * textScaleFactor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
