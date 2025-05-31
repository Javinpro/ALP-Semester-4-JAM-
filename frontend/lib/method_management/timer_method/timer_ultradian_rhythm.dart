import 'package:flutter/material.dart';
import 'package:jam/colors.dart'; // Pastikan path ini benar
import 'package:jam/text_template.dart'; // Pastikan path ini benar
import 'dart:async'; // Untuk Timer
import 'package:image_picker/image_picker.dart'; // Untuk mengakses kamera (tambahkan di pubspec.yaml)

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
  int _studyTimeInSeconds = 90 * 60; // 90 menit untuk study time
  int _restTimeInSeconds = 30 * 60; // 30 menit untuk rest time
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

  void _handleTimerCompletion() {
    if (_currentStatus == UltradianRhythmStatus.study) {
      // Pindah ke rest time
      setState(() {
        _currentStatus = UltradianRhythmStatus.rest;
        _currentSeconds = _restTimeInSeconds;
      });
      _startTimer(); // Mulai timer untuk rest time
    } else if (_currentStatus == UltradianRhythmStatus.rest) {
      // Rest time selesai, tampilkan modal dan kemudian halaman kamera
      _timer?.cancel(); // Pastikan timer berhenti
      _showTakeFotoModal(context);
    }
  }

  // Fungsi untuk menampilkan modal informasi ambil foto
  Future<void> _showTakeFotoModal(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Waktunya Ambil Foto!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Ambil foto apapun yang menggambarkan momen ini untuk melanjutkan metode ${widget.methodName}.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 15),
                Text(
                  'Foto ini tidak akan disimpan secara permanen di perangkat Anda atau dibagikan tanpa izin Anda.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Oke, Ambil Foto!',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup modal
                _takePicture(); // Panggil fungsi ambil foto
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengambil foto (placeholder)
  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto berhasil diambil: ${image.path}')),
        );
        // Di sini Anda bisa memproses foto (misalnya, menampilkannya, atau menyimpannya)
        // Setelah foto diambil, set status menjadi completed
        setState(() {
          _currentStatus = UltradianRhythmStatus.completed;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengambilan foto dibatalkan.')),
        );
        // Jika dibatalkan, mungkin langsung ke status completed atau kembali ke halaman sebelumnya
        setState(() {
          _currentStatus = UltradianRhythmStatus.completed;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengakses kamera: $e')));
      // Jika ada error, set status menjadi completed
      setState(() {
        _currentStatus = UltradianRhythmStatus.completed;
      });
    }
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

  void _forceStopAndGoBack() {
    _timer?.cancel();
    setState(() {
      _currentStatus =
          UltradianRhythmStatus.completed; // Atur status menjadi Completed
      _currentSeconds = 0; // Reset timer
    });
    Navigator.pop(context); // Kembali ke halaman sebelumnya (detail method)
  }

  // --- Fungsi untuk menampilkan modal konfirmasi Stop Method ---
  Future<void> _showStopMethodConfirmationModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus berinteraksi dengan tombol
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Stop Method',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Klik "Continue" untuk melanjutkan metode, atau klik "Stop" untuk kembali ke halaman detail metode.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Stop',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup modal
                _forceStopAndGoBack(); // Panggil fungsi untuk menghentikan timer dan kembali
              },
            ),
            TextButton(
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup modal
                // Tidak perlu melakukan apa-apa lagi, timer akan terus berjalan
              },
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

    if (_currentStatus == UltradianRhythmStatus.study ||
        _currentStatus == UltradianRhythmStatus.rest) {
      stepText =
          (_currentStatus == UltradianRhythmStatus.study)
              ? 'study time'
              : 'rest time';
      buttonText = 'Stop';
      onButtonPressed = _showStopMethodConfirmationModal;
      buttonColor = redColor; // Warna merah untuk tombol Stop
      buttonTextStyle = headerwhite; // Teks putih untuk tombol Stop
    } else {
      // UltradianRhythmStatus.completed
      stepText = 'Completed Method';
      buttonText = 'Back to Home';
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
              width: 355,
              height: 355,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(color: secondaryColor, width: 5),
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
