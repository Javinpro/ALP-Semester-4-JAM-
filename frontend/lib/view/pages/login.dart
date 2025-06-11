import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/widgets/colors.dart';
import 'package:jam/view/widgets/custom_text_field.dart';
import 'package:jam/main.dart';
import 'package:jam/view/pages/register.dart';
import 'package:jam/view/widgets/text_template.dart';
import 'package:jam/viewmodels/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final loginState = ref.watch(loginViewModelProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sizedbox9,
                  Image.asset('assets/img/logo.png', height: 100, width: 100),
                  sizedbox9,
                  const Text(
                    'Welcome To JAM',
                    style: headerblack3,
                    textAlign: TextAlign.center,
                  ),
                  sizedbox5,
                  const Text(
                    'Login below to manage and access all of our features',
                    style: body1,
                    textAlign: TextAlign.center,
                  ),
                  sizedbox4,
                  CustomTextField(
                    labelText: 'Username',
                    prefixIcon: Icons.account_circle_outlined,
                    controller: usernameController,
                    readOnly: false,
                  ),
                  sizedbox2,
                  CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    controller: passwordController,
                    obscureText: true,
                    readOnly: false,
                  ),
                  sizedbox2,
                  if (loginState.errorMessage != null)
                    Text(
                      loginState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: loginState.isLoading
                          ? null
                          : () async {
                              final success = await ref
                                  .read(loginViewModelProvider.notifier)
                                  .login(
                                    usernameController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                              if (success && context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FloatingBottomBar(),
                                  ),
                                );
                              }
                            },
                      child: loginState.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('Login', style: headerblack),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ",
                          style: headerblack2),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text('Click here', style: headeryellow),
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
