// viewmodels/method_list_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/models/method.dart'; // Import your Method model

class MethodListViewModel extends StateNotifier<List<Method>> {
  MethodListViewModel() : super(Method.defaultMethods);

  void filterMethods(String query) {
    if (query.isEmpty) {
      state = Method.defaultMethods;
    } else {
      state =
          Method.defaultMethods.where((method) {
            final titleLower = method.title.toLowerCase();
            final descriptionLower = method.title2.toLowerCase();
            final searchLower = query.toLowerCase();

            return titleLower.contains(searchLower) ||
                descriptionLower.contains(searchLower);
          }).toList();
    }
  }
}

final methodListViewModelProvider =
    StateNotifierProvider<MethodListViewModel, List<Method>>(
      (ref) => MethodListViewModel(),
    );
