import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';

import 'package:jam/view/widgets/custom_text_field.dart';
import 'package:jam/view/pages/login.dart';
import 'package:jam/view/pages/terms_conditions.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final auth = ref.read(authServiceProvider);

    final success = await auth.register(
      username: _username.text.trim(),
      password: _password.text.trim(),
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        _error = 'Register gagal. Periksa data anda.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sizedbox9,
                  Image.asset('assets/img/logo.png', height: 100, width: 100),
                  sizedbox9,
                  const Text(
                    'Selamat datang di JAM',
                    style: headerblack3,
                    textAlign: TextAlign.center,
                  ),
                  sizedbox5,
                  const Text(
                    'Daftarkan akun Anda di bawah ini untuk mengakses semua fitur kami',
                    style: body1,
                    textAlign: TextAlign.center,
                  ),
                  sizedbox4,
                  CustomTextField(
                    labelText: 'Nama Depan',
                    prefixIcon: Icons.person_outline,
                    controller: _firstName,
                    readOnly: false,
                  ),
                  sizedbox2,
                  CustomTextField(
                    labelText: 'Nama Belakang',
                    prefixIcon: Icons.person,
                    controller: _lastName,
                    readOnly: false,
                  ),
                  sizedbox2,
                  CustomTextField(
                    labelText: 'Username',
                    prefixIcon: Icons.account_circle_outlined,
                    controller: _username,
                    readOnly: false,
                  ),
                  sizedbox2,
                  CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    controller: _password,
                    obscureText: true,
                    readOnly: false,
                  ),
                  sizedbox2,
                  if (_error != null)
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  sizedbox6,
                  Wrap(
                    children: [
                      const Text(
                        "Dengan mendaftar, saya setuju dengan ",
                        style: headerblack2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TermsConditions(),
                            ),
                          );
                        },
                        child: const Text(
                          'syarat & ketentuan',
                          style: headeryellow,
                        ),
                      ),
                      const Text(" dari JAM", style: headerblack2),
                    ],
                  ),
                  sizedbox4,
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isLoading ? null : _handleRegister,
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text('Daftar', style: headerblack),
                    ),
                  ),
                  sizedbox6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah memiliki akun? ", style: headerblack2),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Klik di sini', style: headeryellow),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
