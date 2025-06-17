// view/pages/method_management/timer_method/timer_podomoro.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/timer_status.dart'; // Import enum
import 'package:jam/viewmodels/pomodoro_timer_viewmodel.dart'; // Import ViewModel
import 'package:jam/view/pages/method_management/detail_method/pomodoro.dart'; // Import PomodoroDetailPage

class PomodoroTimerPage extends ConsumerWidget {
  final String methodId;

  const PomodoroTimerPage({super.key, required this.methodId});

  // Fungsi untuk menampilkan dialog konfirmasi
  // Pastikan notifier di-pass ke sini
  Future<bool?> _showStopConfirmationDialog(
    BuildContext context,
    PomodoroTimerViewModel notifier,
  ) async {
    //
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Konfirmasi Berhenti',
            style: headerblack4,
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Apakah Anda yakin ingin menghentikan sesi timer ini?',
            style: body1,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(
                      dialogContext,
                    ).pop(false); // Jangan berhenti, tutup dialog
                  },
                  child: const Text('Lanjutkan', style: headerwhite),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    notifier.stopTimer(); // Hentikan timer di ViewModel
                    Navigator.of(
                      dialogContext,
                    ).pop(true); // Tutup dialog dan beri tahu ingin berhenti
                    // Kembali ke halaman detail Pomodoro dan hapus halaman timer dari stack
                    Navigator.pushAndRemoveUntil(
                      //
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PomodoroDetailPage(
                              //
                              title:
                                  "Pomodoro", // Sesuaikan ini jika title perlu dinamis dari methodId
                              title2:
                                  "Fokus 25 menit, istirahat 5 menit.", // Sesuaikan
                              title3: "How to use:", // Sesuaikan
                              imagePath: "assets/img/Pomodoro.jpg", // Sesuaikan
                            ),
                      ),
                      (Route<dynamic> route) =>
                          route
                              .isFirst, // Hapus semua rute sampai rute pertama (biasanya halaman utama/dashboard)
                      // Atau Anda bisa menggunakan (Route<dynamic> route) => route.settings.name == '/pomodoroDetail',
                      // jika Anda menggunakan named routes dan ingin kembali spesifik ke detail.
                    );
                  },
                  child: const Text('Berhenti', style: headerblack),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog intro foto
  Future<void> _showImageIntroDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Waktunya Ambil Foto!',
            style: headerblack4,
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Ambil foto untuk mencatat progress Anda dan lanjutkan sesi!',
            style: body1,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  onConfirm(); // Panggil fungsi untuk mengambil foto dan menghentikan getaran
                },
                child: const Text('Ambil Foto', style: headerblack),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog "Lanjutkan Sesi?"
  Future<void> _showContinueTimerDialog(
    BuildContext context,
    VoidCallback onContinue,
    VoidCallback onGoBack,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Lanjutkan Sesi?',
            style: headerblack4,
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Sesi istirahat telah berakhir. Apakah Anda ingin melanjutkan sesi atau kembali ke beranda?',
            style: body1,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onGoBack(); // Kembali ke beranda
                  },
                  child: const Text('Kembali', style: headerwhite),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    onContinue(); // Lanjutkan sesi
                  },
                  child: const Text('Lanjutkan', style: headerblack),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(pomodoroTimerViewModelProvider(methodId));
    final notifier = ref.read(
      pomodoroTimerViewModelProvider(methodId).notifier,
    );

    final currentSeconds = timerState['currentSeconds'] as int;
    final currentStatus = timerState['currentStatus'] as TimerStatus;
    final selectedImagePath = timerState['selectedImagePath'] as String?;
    final isRunning = timerState['isRunning'] as bool;
    final isVibrating =
        timerState['isVibrating'] as bool; // Dapatkan status getaran

    String _formatTime(int seconds) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }

    String stepText = '';
    Color buttonColor;
    String buttonText = '';
    TextStyle buttonTextStyle;

    switch (currentStatus) {
      case TimerStatus.study:
        stepText = 'Waktunya Fokus!';
        buttonColor = primaryColor;
        buttonText = 'Stop Timer'; // Hanya tombol stop
        buttonTextStyle = headerblack;
        break;
      case TimerStatus.rest:
        stepText = 'Waktunya Istirahat!';
        buttonColor = secondaryColor;
        buttonText = 'Stop Timer'; // Hanya tombol stop
        buttonTextStyle = headerwhite;
        break;
      case TimerStatus.completed:
        stepText = 'Sesi Selesai!';
        buttonColor = Colors.green;
        buttonText = 'Kembali ke Beranda'; // Hanya kembali ke beranda
        buttonTextStyle = headerwhite;
        break;
      case TimerStatus.paused:
        stepText = 'Timer Dijeda';
        buttonColor = Colors.orange;
        buttonText = 'Stop Timer'; // Tetap tombol stop
        buttonTextStyle = headerblack;
        break;
    }

    // Logic untuk tombol utama di halaman timer
    Function() onButtonPressed;
    if (currentStatus == TimerStatus.completed) {
      onButtonPressed = () {
        notifier.resetTimer();
        Navigator.pop(
          context,
        ); // Kembali ke halaman sebelumnya (misal halaman Methods)
      };
    } else {
      onButtonPressed = () async {
        final confirm = await _showStopConfirmationDialog(
          context,
          notifier,
        ); // // Pass notifier
        // Logika stop dan navigasi sudah ditangani di dalam _showStopConfirmationDialog
      };
    }

    // Listener untuk showConfirmationDialogProvider
    ref.listen<bool>(showConfirmationDialogProvider, (previous, next) async {
      if (next) {
        // Panggil dialog dengan notifier, navigasi dilakukan di dalam dialog itu sendiri
        await _showStopConfirmationDialog(context, notifier); //
        ref.read(showConfirmationDialogProvider.notifier).state =
            false; // Reset provider
      }
    });

    // Listener untuk showImageIntroDialogProvider
    ref.listen<bool>(showImageIntroDialogProvider, (previous, next) async {
      if (next) {
        await _showImageIntroDialog(context, () {
          notifier
              .pickImage(); // Mulai proses ambil foto (akan menghentikan getaran)
          // Setelah foto diambil, timer akan otomatis melanjutkan ke fase berikutnya di ViewModel
        });
        ref.read(showImageIntroDialogProvider.notifier).state =
            false; // Reset provider
      }
    });

    // Listener untuk showContinueTimerDialogProvider
    ref.listen<bool>(showContinueTimerDialogProvider, (previous, next) async {
      if (next) {
        await _showContinueTimerDialog(
          context,
          () {
            // Lanjutkan sesi (otomatis mulai study phase dari ViewModel)
            notifier.startTimer(); //
          },
          () {
            notifier.resetTimer(); // Reset dan kembali ke beranda
            Navigator.pop(
              context,
            ); // Kembali ke halaman sebelumnya (misal halaman Methods)
          },
        );
        ref.read(showContinueTimerDialogProvider.notifier).state =
            false; // Reset provider
      }
    });

    // Mengatur perilaku tombol kembali fisik (device back button)
    return PopScope(
      canPop: false, // Menonaktifkan pop otomatis
      onPopInvoked: (didPop) async {
        if (didPop)
          return; // Jika sudah di-pop secara otomatis, jangan lakukan apa-apa

        // Cek jika timer sedang berjalan atau di-pause (tidak dalam status completed)
        if (currentStatus != TimerStatus.completed) {
          final confirm = await _showStopConfirmationDialog(
            context,
            notifier,
          ); // // Pass notifier
          if (confirm == true) {
            // Navigasi sudah ditangani di dalam _showStopConfirmationDialog
          }
        } else {
          // Jika sudah completed, biarkan tombol back berfungsi normal
          Navigator.pop(
            context,
          ); // Kembali ke halaman sebelumnya (misal halaman Methods)
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading:
              false, // Tetap false untuk tidak menampilkan tombol back otomatis
          elevation: 0,
          centerTitle: true,
          title: Text(
            methodId == 'pomodoro' ? 'Pomodoro' : '',
            style: headerblack4,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer Display
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color:
                        isVibrating
                            ? Colors.redAccent
                            : secondaryColor, // Indikator getaran
                    width: 5,
                  ),
                ),
                child: Center(
                  child: Text(_formatTime(currentSeconds), style: headerblack5),
                ),
              ),
              const SizedBox(height: 40),
              // Text Step
              Text(
                stepText,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),
              // Button Stop / Back to Home
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    shadowColor: secondaryColor.withOpacity(0.4),
                  ),
                  onPressed: onButtonPressed,
                  child: Text(buttonText, style: buttonTextStyle),
                ),
              ),
              if (selectedImagePath != null &&
                  selectedImagePath.isNotEmpty) // Tampilkan gambar yang diambil
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.file(
                    File(selectedImagePath),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
