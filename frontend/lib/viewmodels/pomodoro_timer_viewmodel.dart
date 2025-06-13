// viewmodels/pomodoro_timer_viewmodel.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jam/models/method.dart';
import 'package:jam/models/timer_status.dart';
import 'package:jam/services/image_picker_service.dart';
import 'package:jam/services/vibration_service.dart';
import 'package:jam/services/method_data_service.dart';

// Tambahkan provider untuk memicu dialog, karena ViewModel tidak bisa langsung showDialog
final showConfirmationDialogProvider = StateProvider<bool>((ref) => false);
final showImageIntroDialogProvider = StateProvider<bool>((ref) => false);
final showContinueTimerDialogProvider = StateProvider<bool>((ref) => false);

final pomodoroTimerViewModelProvider = StateNotifierProvider.family<
  PomodoroTimerViewModel,
  Map<String, dynamic>,
  String
>((ref, methodId) {
  final vibrationService = ref.watch(vibrationServiceProvider);
  final imagePickerService = ref.watch(imagePickerServiceProvider);
  final methodDataService = ref.watch(methodDataServiceProvider);
  final method = methodDataService.getMethodById(methodId);

  return PomodoroTimerViewModel(
    vibrationService,
    imagePickerService,
    method!, // Pastikan method tidak null karena sudah dicari ID-nya
    ref, // Berikan ref ke ViewModel
  );
});

class PomodoroTimerViewModel extends StateNotifier<Map<String, dynamic>> {
  final VibrationService _vibrationService;
  final ImagePickerService _imagePickerService;
  final Method _method; // Mengambil data default dari Method model
  final Ref _ref; // Tambahkan Ref untuk berinteraksi dengan provider lain

  Timer? _timer;
  // Timer khusus untuk getaran berkelanjutan, dihapus karena vibrationService sudah bisa mengelola

  PomodoroTimerViewModel(
    this._vibrationService,
    this._imagePickerService,
    this._method,
    this._ref, // Inisialisasi ref
  ) : super({
        'currentSeconds': _method.studyDurationSeconds,
        'currentStatus': TimerStatus.study,
        'selectedImagePath': null,
        'isRunning': false,
        'isVibrating': false, // Tambahkan status getaran
      }) {
    // Inisialisasi awal, bisa juga di sini
    // state = {...state, 'currentSeconds': _method.studyDurationSeconds};
  }

  int get _studyTime => _method.studyDurationSeconds;
  int get _restTime => _method.restDurationSeconds;

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _timer?.cancel(); // Pastikan tidak ada timer yang berjalan
    state = {...state, 'isRunning': true}; // Set running state segera

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state['currentSeconds'] > 0) {
        state = {...state, 'currentSeconds': state['currentSeconds'] - 1};
      } else {
        _timer?.cancel();
        _vibrationService.cancelVibration(); // Hentikan getaran sebelumnya

        if (state['currentStatus'] == TimerStatus.study) {
          // Study phase ends, go to rest phase
          state = {
            ...state,
            'currentStatus': TimerStatus.rest,
            'currentSeconds': _restTime,
            'isRunning': false, // Hentikan timer sebelum dialog
          };
          // Tampilkan dialog intro foto dan mulai getaran
          _ref.read(showImageIntroDialogProvider.notifier).state = true;
          startContinuousVibration(); // Mulai getaran berkelanjutan
        } else {
          // Rest phase ends, go to completed and show continue dialog
          state = {
            ...state,
            'currentStatus': TimerStatus.completed,
            'currentSeconds': 0,
            'isRunning': false, // Pastikan timer berhenti
          };
          // Tampilkan dialog konfirmasi untuk melanjutkan atau kembali
          _ref.read(showContinueTimerDialogProvider.notifier).state = true;
          // Getaran sudah dihentikan di awal block else ini, biarkan seperti itu.
        }
      }
    });
  }

  // Metode untuk memulai timer dari awal atau melanjutkan dari jeda
  void startTimer() {
    // Jika status completed, reset dulu
    if (state['currentStatus'] == TimerStatus.completed) {
      resetTimer();
    }
    _startTimer();
  }

  void stopTimer() {
    _timer?.cancel();
    _vibrationService.cancelVibration();
    state = {
      ...state,
      'isRunning': false,
      'currentStatus': TimerStatus.paused, // Set status ke paused
    };
    _ref.read(showConfirmationDialogProvider.notifier).state =
        false; // Sembunyikan dialog jika ada
  }

  void resetTimer() {
    _timer?.cancel();
    _vibrationService.cancelVibration();
    state = {
      'currentSeconds': _studyTime,
      'currentStatus': TimerStatus.study,
      'selectedImagePath': null,
      'isRunning': false,
      'isVibrating': false,
    };
  }

  // Metode untuk mengganti antara Study dan Rest secara manual (opsional, mungkin tidak dipakai lagi)
  void togglePhase() {
    _timer?.cancel();
    _vibrationService.cancelVibration();
    if (state['currentStatus'] == TimerStatus.study) {
      state = {
        ...state,
        'currentStatus': TimerStatus.rest,
        'currentSeconds': _restTime,
        'isRunning': false,
      };
    } else if (state['currentStatus'] == TimerStatus.rest) {
      state = {
        ...state,
        'currentStatus': TimerStatus.study,
        'currentSeconds': _studyTime,
        'isRunning': false,
      };
    }
  }

  Future<void> pickImage() async {
    _vibrationService
        .cancelVibration(); // Hentikan getaran saat mulai ambil foto
    state = {...state, 'isVibrating': false}; // Perbarui status getaran
    final XFile? image = await _imagePickerService.pickImageFromCamera();
    if (image != null) {
      state = {...state, 'selectedImagePath': image.path};
    }
  }

  void startContinuousVibration() {
    _vibrationService.vibrate(
      pattern: [0, 1000, 500, 1000], // Contoh pola getaran terus-menerus
      repeat: 0, // Ulangi terus-menerus
    );
    state = {...state, 'isVibrating': true};
  }

  void stopVibration() {
    _vibrationService.cancelVibration();
    state = {...state, 'isVibrating': false};
  }

  @override
  void dispose() {
    _timer?.cancel();
    _vibrationService.cancelVibration();
    super.dispose();
  }
}
