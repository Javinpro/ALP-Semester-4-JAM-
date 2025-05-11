import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/custom_text_field.dart';
import 'package:jam/edit_profile.dart';
import 'package:jam/text_template.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150/0000FF/808080?Text=Profile',
                ), // Replace with your image URL
              ),
              const SizedBox(height: 42),
              const CustomTextField(
                labelText: 'First Name',
                prefixIcon: Icons.person_outline,
                readOnly: true,
              ),
              sizedbox2,
              const CustomTextField(
                labelText: 'Last Name',
                prefixIcon: Icons.person_outline,
                readOnly: true,
              ),
              sizedbox2,
              const CustomTextField(
                labelText: 'Username',
                prefixIcon: Icons.account_circle_outlined,
                readOnly: true,
              ),

              sizedbox2,
              const CustomTextField(
                labelText: 'Password',
                prefixIcon: Icons.lock_outline,
                readOnly: true,
              ),

              const SizedBox(height: 83),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ), // Replace with your EditProfilePage widget
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
                      ),
                      onPressed: () {
                        // Implement your logout logic here
                        print('Logout button pressed');
                      },
                      child: const Text('Logout', style: headerred),
                    ),
                  ),

                  const SizedBox(height: 130),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
