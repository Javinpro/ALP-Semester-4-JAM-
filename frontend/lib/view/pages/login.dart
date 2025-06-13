import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/widgets/custom_text_field.dart';
import 'package:jam/main.dart';
import 'package:jam/view/pages/register.dart';
import 'package:jam/view/utils/text_template.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  const CustomTextField(
                    labelText: 'Username',
                    prefixIcon: Icons.account_circle_outlined,
                    readOnly: false,
                  ),
                  sizedbox2,
                  const CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    readOnly: false,
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
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FloatingBottomBar(),
                          ),
                        );
                      },
                      child: const Text('Login', style: headerblack),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: headerblack2,
                      ),
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
