import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/viewmodels/login_state.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(ref.read(authServiceProvider)),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthService _authService;

  LoginViewModel(this._authService) : super(const LoginState());

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final success = await _authService.login(username, password);

    if (success) {
      state = state.copyWith(isLoading: false);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Login gagal. Periksa username dan password.',
      );
      return false;
    }
  }
}
