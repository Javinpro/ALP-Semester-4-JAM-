import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jam/colors.dart';
import 'package:jam/custom_text_field.dart';
import 'package:jam/text_template.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Tidak ada gambar yang dipilih.');
      }
    });
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Sumber Gambar"),
          actions: <Widget>[
            TextButton(
              child: const Text("Kamera"),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text("Galeri"),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Edit Profile', style: headerblack4),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.3),
                  spreadRadius: 0, // Seberapa jauh bayangan menyebar
                  blurRadius: 6, // Seberapa buram bayangan
                  offset: const Offset(0, 3), // Pergeseran bayangan (x, y)
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: secondaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 130),

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        _image != null
                            ? FileImage(_image!)
                            : const NetworkImage(
                                  'https://via.placeholder.com/150/0000FF/808080?Text=Profile',
                                )
                                as ImageProvider,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showImageSourceDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Icon(Icons.edit, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42),
              const CustomTextField(
                labelText: 'First Name',
                prefixIcon: Icons.person_outline,
              ),
              sizedbox2,
              const CustomTextField(
                labelText: 'Last Name',
                prefixIcon: Icons.person_outline,
              ),
              sizedbox2,
              const CustomTextField(
                labelText: 'Username',
                prefixIcon: Icons.account_circle_outlined,
              ),
              sizedbox2,
              const CustomTextField(
                labelText: 'Password',
                prefixIcon: Icons.lock_outline,
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
                      onPressed: () {},
                      child: const Text('Save', style: headerblack),
                    ),
                  ),
                  sizedbox3,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
