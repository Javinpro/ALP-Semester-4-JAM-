import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk ImagePicker (digunakan di ViewModel lain)
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider((ref) => ImagePicker());
