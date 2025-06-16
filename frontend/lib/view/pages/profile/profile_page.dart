import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/view/pages/profile/edit_profile.dart';
import 'package:jam/view/pages/login.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/viewmodels/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: profileAsync.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                sizedbox3,
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150/0000FF/808080?Text=Profile',
                  ),
                ),
                const SizedBox(height: 42),
                CustomTextField(
                  labelText: 'First Name',
                  prefixIcon: Icons.person_outline,
                  readOnly: true,
                  initialValue: data['first_name'] ?? '',
                ),
                sizedbox2,
                CustomTextField(
                  labelText: 'Last Name',
                  prefixIcon: Icons.person,
                  readOnly: true,
                  initialValue: data['last_name'] ?? '',
                ),
                sizedbox2,
                CustomTextField(
                  labelText: 'Username',
                  prefixIcon: Icons.account_circle_outlined,
                  readOnly: true,
                  initialValue: data['username'] ?? '',
                ),
                sizedbox2,
                const CustomTextField(
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  readOnly: true,
                  initialValue: '********',
                ),
                const SizedBox(height: 83),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(),
                            ),
                          );
                        },
                        child: const Text('Edit Profile', style: headerblack),
                      ),
                    ),
                    sizedbox1,
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          foregroundColor: redColor,
                          side: BorderSide(color: redColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () async {
                          final result = await authService.logout();
                          if (result && context.mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Text('Logout', style: headerred),
                      ),
                    ),
                    const SizedBox(height: 130),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error loading profile: $err')),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool readOnly;
  final String? initialValue;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.readOnly = false,
    this.initialValue,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
