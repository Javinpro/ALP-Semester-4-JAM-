import 'package:flutter/material.dart';
import 'package:jam/colors.dart'; // Pastikan path ini benar
import 'package:jam/text_template.dart'; // Pastikan path ini benar
import 'dart:async'; // Untuk Timer
import 'package:image_picker/image_picker.dart'; // Untuk mengakses kamera (tambahkan di pubspec.yaml)

// Enum untuk status timer
enum PomodoroStatus { study, rest, completed }

class PomodoroTimerPage extends StatefulWidget {
  final String methodName;

  const PomodoroTimerPage({super.key, required this.methodName});

  @override
  State<PomodoroTimerPage> createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage> {
  Timer? _timer;
  int _studyTimeInSeconds = 25 * 60;
  int _restTimeInSeconds = 10 * 60;
  int _currentSeconds = 0;
  PomodoroStatus _currentStatus = PomodoroStatus.study;
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

  void _handleTimerCompletion() {
    if (_currentStatus == PomodoroStatus.study) {
      // Pindah ke rest time
      setState(() {
        _currentStatus = PomodoroStatus.rest;
        _currentSeconds = _restTimeInSeconds;
      });
      _startTimer(); // Mulai timer untuk rest time
    } else if (_currentStatus == PomodoroStatus.rest) {
      // Rest time selesai, tampilkan modal ambil foto
      _timer?.cancel(); // Pastikan timer berhenti
      _showTakeFotoModal(context);
    }
  }

  // Fungsi yang sekarang dipanggil oleh modal "Stop Method"
  void _forceStopAndGoBack() {
    _timer?.cancel();
    setState(() {
      _currentStatus =
          PomodoroStatus.completed; // Atur status menjadi Completed
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
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto berhasil diambil: ${image.path}')),
        );
        // Setelah foto diambil, tampilkan modal konfirmasi berikutnya
        _showNextCycleConfirmationModal();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengambilan foto dibatalkan.')),
        );
        // Jika dibatalkan, tetap tawarkan pilihan lanjutan atau kembali
        _showNextCycleConfirmationModal(); // Masih menawarkan konfirmasi setelah pembatalan
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengakses kamera: $e')));
      // Jika ada error, tetap tawarkan pilihan lanjutan atau kembali
      _showNextCycleConfirmationModal(); // Masih menawarkan konfirmasi setelah error
    }
  }

  // --- Fungsi Baru: Modal Konfirmasi Lanjutkan Siklus Timer ---
  Future<void> _showNextCycleConfirmationModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus berinteraksi dengan tombol
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
                    side: const BorderSide(
                      color: redColor,
                      width: 3,
                    ), // Border for "Keluar"
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Tutup modal
                    Navigator.pop(
                      context,
                    ); // Kembali ke halaman sebelumnya (detail method)
                    // Set status completed jika perlu di halaman sebelumnya
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
                    Navigator.of(dialogContext).pop(); // Tutup modal
                    // Lanjutkan siklus timer
                    setState(() {
                      _currentStatus = PomodoroStatus.study;
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
    _timer?.cancel(); // Pastikan timer dibatalkan saat widget dihapus
    super.dispose();
  }

  // --- Fungsi untuk menampilkan modal konfirmasi Stop Method ---
  Future<void> _showStopMethodConfirmationModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus berinteraksi dengan tombol
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: const Text(
            'Hentikan Metode',
            style: headerblack4,
            textAlign: TextAlign.center, // Center the title text
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Dengan mengklik lanjutkan untuk meneruskan metode atau klik berhenti untuk kembali ke metode detail.',
                  style: body1,
                  textAlign: TextAlign.center, // Center the content text
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // --- Wrap both buttons in a Row and center the Row ---
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceEvenly, // Distribute space evenly between and around buttons
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal:
                          20.0, // Adjusted padding to fit well within AlertDialog
                      vertical: 15.0, // Adjusted padding
                    ),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(
                      color: redColor, // Border color to match the button
                      width: 3, // Border width
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close modal
                    _forceStopAndGoBack(); // Call the function to stop the timer and go back
                  },
                  child: const Text(
                    'Stop',
                    style: headerred,
                  ), // Changed text style for better contrast
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, // Adjusted padding
                      vertical: 15.0, // Adjusted padding
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close modal
                    // Tidak perlu melakukan apa-apa lagi, timer akan terus berjalan
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
    Color buttonColor; // Variabel baru untuk warna tombol
    TextStyle buttonTextStyle; // Variabel baru untuk style teks tombol

    if (_currentStatus == PomodoroStatus.study ||
        _currentStatus == PomodoroStatus.rest) {
      stepText =
          (_currentStatus == PomodoroStatus.study) ? 'Study Time' : 'Rest Time';
      buttonText = 'Berhenti';
      onButtonPressed = _showStopMethodConfirmationModal;
      buttonColor = redColor; // Warna merah untuk tombol Stop
      buttonTextStyle = headerwhite; // Teks putih untuk tombol Stop
    } else {
      // PomodoroStatus.completed
      stepText = 'Metode Selesai';
      buttonText = 'Kembali';
      onButtonPressed = () {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        ); // Kembali ke root (MethodPage)
      };
      buttonColor = primaryColor; // Warna utama untuk tombol Back to Home
      buttonTextStyle = headerblack; // Teks hitam untuk tombol Back to Home
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
                  backgroundColor:
                      buttonColor, // Gunakan warna tombol yang ditentukan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: secondaryColor.withOpacity(0.4),
                ),
                onPressed: onButtonPressed,
                child: Text(
                  buttonText,
                  style: buttonTextStyle,
                ), // Gunakan style teks tombol yang ditentukan
              ),
            ),
          ],
        ),
      ),
    );
  }
}
