import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

final vibrationServiceProvider = Provider((ref) => VibrationService());

class VibrationService {
  Future<void> vibrate({int? duration, List<int>? pattern, int? repeat}) async {
    // Memastikan nilai non-nullable sesuai dengan kebutuhan package Vibration
    // Kita asumsikan default duration 500ms jika null
    if (await Vibration.hasVibrator() ?? false) {
      if (pattern != null) {
        // Jika ada pattern, gunakan pattern
        if (await Vibration.hasCustomVibrationsSupport() ?? false) {
          await Vibration.vibrate(pattern: pattern, repeat: repeat ?? -1);
        } else {
          // Fallback jika custom vibrations tidak didukung
          await Vibration.vibrate(duration: 500); // Getar singkat
        }
      } else {
        // Jika tidak ada pattern, gunakan duration
        await Vibration.vibrate(duration: duration ?? 500);
      }
    }
  }

  Future<void> cancelVibration() async {
    await Vibration.cancel();
  }
}
