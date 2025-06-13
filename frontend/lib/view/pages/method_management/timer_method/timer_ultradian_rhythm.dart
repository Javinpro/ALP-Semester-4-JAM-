import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/timer_status.dart';
import 'package:jam/viewmodels/ultradian_rhythm_timer_viewmodel.dart'; // Import ViewModel

class UltradianRhythmTimerPage extends ConsumerWidget {
  final String methodId;

  const UltradianRhythmTimerPage({super.key, required this.methodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(
      ultradianRhythmTimerViewModelProvider(methodId),
    );
    final notifier = ref.read(
      ultradianRhythmTimerViewModelProvider(methodId).notifier,
    );

    final currentSeconds = timerState['currentSeconds'] as int;
    final currentStatus = timerState['currentStatus'] as TimerStatus;
    final selectedImagePath = timerState['selectedImagePath'] as String?;
    final isRunning = timerState['isRunning'] as bool;

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
        buttonText = isRunning ? 'Pause' : 'Start';
        buttonTextStyle = headerblack;
        break;
      case TimerStatus.rest:
        stepText = 'Waktunya Istirahat!';
        buttonColor = secondaryColor;
        buttonText = isRunning ? 'Pause' : 'Start';
        buttonTextStyle = headerwhite;
        break;
      case TimerStatus.completed:
        stepText = 'Sesi Selesai!';
        buttonColor = Colors.green;
        buttonText = 'Kembali ke Beranda';
        buttonTextStyle = headerwhite;
        break;
      case TimerStatus.paused:
        stepText = 'Timer Dijeda';
        buttonColor = Colors.orange;
        buttonText = 'Lanjutkan';
        buttonTextStyle = headerblack;
        break;
    }

    Function() onButtonPressed;
    if (currentStatus == TimerStatus.completed) {
      onButtonPressed = () {
        notifier.resetTimer();
        Navigator.pop(context);
      };
    } else {
      onButtonPressed = () {
        notifier.startOrPauseTimer();
      };
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          methodId == 'ultradian_rhythm' ? 'Ultradian Rhythm Timer' : '',
          style: headerblack4,
        ),
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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                notifier.resetTimer();
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: primaryColor),
            onPressed: notifier.pickImage,
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, color: primaryColor),
            onPressed: notifier.vibrateContinuously,
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: primaryColor),
            onPressed: notifier.resetTimer,
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: primaryColor),
            onPressed: notifier.togglePhase,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedImagePath != null && selectedImagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(selectedImagePath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      ),
                ),
              )
            else
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 40),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: secondaryColor, width: 5),
              ),
              child: Center(
                child: Text(
                  _formatTime(currentSeconds),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              stepText,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 60),
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
          ],
        ),
      ),
    );
  }
}
