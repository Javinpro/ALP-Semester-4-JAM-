import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Tambahkan ini
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/pages/method_management/timer_method/timer_ultradian_rhythm.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/method.dart'; // Import model Method
import 'package:jam/viewmodels/pomodoro_timer_viewmodel.dart'; // Import ViewModel untuk Ultradian Rhythm juga

class UltradianRhythmPage extends StatelessWidget {
  final String title;
  final String title2;
  final String title3;
  final String imagePath;

  const UltradianRhythmPage({
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
    final textScaleFactor = MediaQuery.of(context).textScaler.scale(1.0);

    final method = Method.defaultMethods.firstWhere((m) => m.title == title);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          title,
          style: headerblack4.copyWith(
            fontSize: headerblack4.fontSize! * textScaleFactor,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.015),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
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
                size: screenWidth * 0.06,
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
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      child: Image.asset(
                        imagePath,
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.25,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Icon(Icons.error, size: screenWidth * 0.35),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    title3,
                    style: headerblack.copyWith(
                      fontSize: headerblack.fontSize! * textScaleFactor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    method.description,
                    style: body2.copyWith(
                      color: Colors.black87,
                      fontSize: body2.fontSize! * textScaleFactor,
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.03), // Hapus SizedBox ini jika tidak diperlukan
                ],
              ),
            ),
          ),
          // Tempatkan tombol di luar SingleChildScrollView, di bagian bawah Column utama
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  elevation: screenWidth * 0.02,
                ),
                onPressed:
                    () => _showStartConfirmationDialog(context, method.id),
                child: Text(
                  'Coba deh!',
                  style: headerblack.copyWith(
                    fontSize: headerblack.fontSize! * textScaleFactor,
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
                              (context) => UltradianRhythmTimerPage(
                                methodId: methodName,
                              ),
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
