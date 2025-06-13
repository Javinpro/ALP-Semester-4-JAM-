import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jam/models/method.dart';
import 'package:jam/models/timer_status.dart';
import 'package:jam/services/image_picker_service.dart';
import 'package:jam/services/vibration_service.dart';
import 'package:jam/services/method_data_service.dart';

final ultradianRhythmTimerViewModelProvider = StateNotifierProvider.family<
  UltradianRhythmTimerViewModel,
  Map<String, dynamic>,
  String
>((ref, methodId) {
  final vibrationService = ref.watch(vibrationServiceProvider);
  final imagePickerService = ref.watch(imagePickerServiceProvider);
  final methodDataService = ref.watch(methodDataServiceProvider);
  final method = methodDataService.getMethodById(methodId);

  return UltradianRhythmTimerViewModel(
    vibrationService,
    imagePickerService,
    method!,
  );
});

class UltradianRhythmTimerViewModel
    extends StateNotifier<Map<String, dynamic>> {
  final VibrationService _vibrationService;
  final ImagePickerService _imagePickerService;
  final Method _method;

  Timer? _timer;
  Timer? _vibrationTimer;

  UltradianRhythmTimerViewModel(
    this._vibrationService,
    this._imagePickerService,
    this._method,
  ) : super({
        'currentSeconds': _method.studyDurationSeconds,
        'currentStatus': TimerStatus.study,
        'selectedImagePath': null,
        'isRunning': false,
      });

  int get _studyTime => _method.studyDurationSeconds;
  int get _restTime => _method.restDurationSeconds;

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state['currentSeconds'] > 0) {
        state = {...state, 'currentSeconds': state['currentSeconds'] - 1};
      } else {
        _timer?.cancel();
        _vibrationService.cancelVibration();
        _vibrationService.vibrate(pattern: [0, 500, 500, 500]);

        if (state['currentStatus'] == TimerStatus.study) {
          state = {
            ...state,
            'currentStatus': TimerStatus.rest,
            'currentSeconds': _restTime,
          };
        } else {
          state = {
            ...state,
            'currentStatus': TimerStatus.completed,
            'currentSeconds': 0,
          };
        }
        if (state['currentStatus'] != TimerStatus.completed) {
          _startTimer();
        } else {
          state = {...state, 'isRunning': false};
        }
      }
    });
    state = {...state, 'isRunning': true};
  }

  void startOrPauseTimer() {
    if (state['isRunning']) {
      _timer?.cancel();
      _vibrationService.cancelVibration();
      state = {
        ...state,
        'isRunning': false,
        'currentStatus': TimerStatus.paused,
      };
    } else {
      if (state['currentStatus'] == TimerStatus.completed) {
        resetTimer();
      }
      _startTimer();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    _vibrationService.cancelVibration();
    state = {
      'currentSeconds': _studyTime,
      'currentStatus': TimerStatus.study,
      'selectedImagePath': null,
      'isRunning': false,
    };
  }

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
    final XFile? image = await _imagePickerService.pickImageFromCamera();
    if (image != null) {
      state = {...state, 'selectedImagePath': image.path};
    }
  }

  void vibrateContinuously() {
    _vibrationService.vibrate(pattern: [0, 1000, 500, 1000], repeat: 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _vibrationTimer?.cancel();
    _vibrationService.cancelVibration();
    super.dispose();
  }
}
