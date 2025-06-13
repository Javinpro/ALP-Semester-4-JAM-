// view/pages/method_management/timer_method/timer_podomoro.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/timer_status.dart'; // Import enum
import 'package:jam/viewmodels/metode5217_timer_viewmodel.dart'; // Import ViewModel

class metode5217TimerPage extends ConsumerWidget {
  final String methodId;

  const metode5217TimerPage({super.key, required this.methodId});

  // Fungsi untuk menampilkan dialog konfirmasi
  Future<bool?> _showStopConfirmationDialog(BuildContext context) async {
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
                    Navigator.of(dialogContext).pop(false); // Jangan berhenti
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
                    Navigator.of(dialogContext).pop(true); // Berhenti
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
    final timerState = ref.watch(metode5217TimerViewModelProvider(methodId));
    final notifier = ref.read(
      metode5217TimerViewModelProvider(methodId).notifier,
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
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      };
    } else {
      onButtonPressed = () async {
        final confirm = await _showStopConfirmationDialog(context);
        if (confirm == true) {
          notifier.stopTimer();
          // Opsional: Langsung kembali ke halaman sebelumnya setelah stop
          // Navigator.pop(context);
        }
      };
    }

    // Listener untuk showConfirmationDialogProvider
    ref.listen<bool>(showConfirmationDialogProvider, (previous, next) async {
      if (next) {
        final confirm = await _showStopConfirmationDialog(context);
        if (confirm == true) {
          notifier.stopTimer();
          // Navigator.pop(context); // Kembali jika pengguna mengkonfirmasi stop
        }
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
            notifier.startTimer();
          },
          () {
            notifier.resetTimer(); // Reset dan kembali ke beranda
            Navigator.pop(context);
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
          final confirm = await _showStopConfirmationDialog(context);
          if (confirm == true) {
            notifier.stopTimer(); // Hentikan timer
            Navigator.pop(context); // Kembali
          }
        } else {
          // Jika sudah completed, biarkan tombol back berfungsi normal
          Navigator.pop(context);
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
            methodId == 'metode5217' ? 'metode5217' : '',
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
