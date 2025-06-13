import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/models/method.dart';

final methodDataServiceProvider = Provider((ref) => MethodDataService());

class MethodDataService {
  List<Method> getAllMethods() {
    return Method.defaultMethods; // Menggunakan data statis dari model
  }

  Method? getMethodById(String id) {
    return Method.defaultMethods.firstWhere(
      (method) => method.id == id,
      orElse: () => throw Exception('Method with ID $id not found'),
    );
  }
}
