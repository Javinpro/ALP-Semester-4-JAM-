import 'package:flutter/material.dart';
import 'package:jam/view/widgets/colors.dart'; // Pastikan path ini benar
import 'package:jam/view/widgets/text_template.dart'; // Pastikan path ini benar
import 'dart:async'; // Untuk Timer
import 'package:image_picker/image_picker.dart'; // Untuk mengakses kamera
import 'package:vibration/vibration.dart'; // Import package vibration

// Enum untuk status timer
enum UltradianRhythmStatus { study, rest, completed }

class UltradianRhythmTimerPage extends StatefulWidget {
  final String methodName;

  const UltradianRhythmTimerPage({super.key, required this.methodName});

  @override
  State<UltradianRhythmTimerPage> createState() =>
      _UltradianRhythmTimerPageState();
}

class _UltradianRhythmTimerPageState extends State<UltradianRhythmTimerPage> {
  Timer? _timer;
  Timer? _vibrationTimer; // Timer khusus untuk getaran berkelanjutan
  int _studyTimeInSeconds = 90 * 60; // 25 menit untuk study time
  int _restTimeInSeconds = 30 * 60; // 10 menit untuk rest time
  int _currentSeconds = 0;
  UltradianRhythmStatus _currentStatus = UltradianRhythmStatus.study;
  final ImagePicker _picker = ImagePicker(); // Instance untuk ImagePicker

  @override
  void initState() {
    super.initState();
    _currentSeconds = _studyTimeInSeconds; // Mulai dengan waktu study
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Pastikan timer sebelumnya dihentikan
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        _timer?.cancel(); // Hentikan timer saat waktu habis
        _handleTimerCompletion();
      } else {
        setState(() {
          _currentSeconds--;
        });
      }
    });
  }

  // --- Fungsi untuk memulai getaran berkelanjutan ---
  void _vibrateContinuously() async {
    if (await Vibration.hasVibrator() ?? false) {
      // Cek apakah perangkat memiliki vibrator
      // Pola: [delay, duration, delay, duration, ...]
      // Kita buat pola looping dengan durasi getar yang cukup panjang
      // dan delay singkat agar terasa terus menerus
      _vibrationTimer = Timer.periodic(const Duration(milliseconds: 1000), (
        timer,
      ) async {
        if (await Vibration.hasCustomVibrationsSupport() ?? false) {
          Vibration.vibrate(
            pattern: [0, 500],
            repeat: -1,
          ); // Getar 0.5 detik, ulangi terus
        } else {
          Vibration.vibrate(duration: 500); // Getar 0.5 detik
        }
      });
    }
  }

  // --- Fungsi untuk menghentikan getaran berkelanjutan ---
  void _stopContinuousVibration() {
    _vibrationTimer?.cancel(); // Hentikan timer getaran
    Vibration.cancel(); // Pastikan semua getaran yang sedang aktif dihentikan
  }

  void _handleTimerCompletion() async {
    if (_currentStatus == UltradianRhythmStatus.study) {
      // Pindah ke rest time
      setState(() {
        _currentStatus = UltradianRhythmStatus.rest;
        _currentSeconds = _restTimeInSeconds;
      });
      _startTimer(); // Mulai timer untuk rest time
    } else if (_currentStatus == UltradianRhythmStatus.rest) {
      // Rest time selesai
      _timer?.cancel(); // Pastikan timer utama berhenti

      // --- Mulai getaran berkelanjutan di sini ---
      _vibrateContinuously();

      _showTakeFotoModal(context); // Tampilkan modal ambil foto
    }
  }

  // Fungsi yang sekarang dipanggil oleh modal "Stop Method"
  void _forceStopAndGoBack() {
    _timer?.cancel();
    _stopContinuousVibration(); // Pastikan getaran berhenti jika pengguna menghentikan manual
    setState(() {
      _currentStatus =
          UltradianRhythmStatus.completed; // Atur status menjadi Completed
      _currentSeconds = 0; // Reset timer
    });
    Navigator.pop(context); // Kembali ke halaman sebelumnya (detail method)
  }

  // Fungsi untuk menampilkan modal "Matikan Alarmnya!!"
  Future<void> _showTakeFotoModal(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text(
            'Matikan Alarmnya!!',
            style: headerblack4,
            textAlign: TextAlign.center, // Center the title text
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Klik "Ambil foto sekarang!" untuk mematikan alarm dan melanjutkan metode.',
                  style: body1,
                  textAlign: TextAlign.center, // Center the content text
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, // Adjusted padding
                    vertical: 18.0, // Adjusted padding
                  ),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close modal
                  _takePicture(); // Call the function to take a picture
                },
                child: const Text('Ambil foto sekarang!', style: headerblack),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengambil foto
  Future<void> _takePicture() async {
    _stopContinuousVibration(); // --- Hentikan getaran di sini ---
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto berhasil diambil: ${image.path}')),
        );
        _showNextCycleConfirmationModal(); // Tampilkan modal konfirmasi berikutnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengambilan foto dibatalkan.')),
        );
        _showNextCycleConfirmationModal(); // Masih menawarkan konfirmasi setelah pembatalan
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengakses kamera: $e')));
      _showNextCycleConfirmationModal(); // Masih menawarkan konfirmasi setelah error
    }
  }

  // Fungsi: Modal Konfirmasi Lanjutkan Siklus Timer
  Future<void> _showNextCycleConfirmationModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text(
            'Lanjutkan Metode?',
            style: headerblack4,
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah Anda ingin melanjutkan siklus metode (kembali ke waktu belajar) atau kembali ke halaman detail metode?',
                  style: body1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: redColor, width: 3),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.pop(context);
                  },
                  child: const Text('Keluar', style: headerred),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    setState(() {
                      _currentStatus = UltradianRhythmStatus.study;
                      _currentSeconds = _studyTimeInSeconds;
                    });
                    _startTimer();
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

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel(); // Pastikan timer utama dibatalkan
    _vibrationTimer?.cancel(); // Pastikan timer getaran juga dibatalkan
    Vibration.cancel(); // Hentikan getaran yang mungkin sedang aktif
    super.dispose();
  }

  // Fungsi untuk menampilkan modal konfirmasi Stop Method
  Future<void> _showStopMethodConfirmationModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text(
            'Hentikan Metode',
            style: headerblack4,
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Dengan mengklik lanjutkan untuk meneruskan metode atau klik berhenti untuk kembali ke metode detail.',
                  style: body1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: redColor, width: 3),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _forceStopAndGoBack();
                  },
                  child: const Text('Stop', style: headerred),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
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
  Widget build(BuildContext context) {
    String stepText;
    String buttonText;
    VoidCallback? onButtonPressed;
    Color buttonColor;
    TextStyle buttonTextStyle;

    if (_currentStatus == UltradianRhythmStatus.study ||
        _currentStatus == UltradianRhythmStatus.rest) {
      stepText =
          (_currentStatus == UltradianRhythmStatus.study)
              ? 'Study Time'
              : 'Rest Time';
      buttonText = 'Berhenti';
      onButtonPressed = _showStopMethodConfirmationModal;
      buttonColor = redColor;
      buttonTextStyle = headerwhite;
    } else {
      stepText = 'Metode Selesai';
      buttonText = 'Kembali';
      onButtonPressed = () {
        Navigator.popUntil(context, (route) => route.isFirst);
      };
      buttonColor = primaryColor;
      buttonTextStyle = headerblack;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('${widget.methodName}', style: headerblack4),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lingkaran Besar Timer
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondaryColor, width: 5),
              ),
              child: Center(
                child: Text(
                  _formatTime(_currentSeconds),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
