import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/view/widgets/custom_text_field.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/viewmodels/profile_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  File? _image;
  final _picker = ImagePicker();

  bool _isSaving = false;
  String? _error;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pilih Sumber Gambar"),
        actions: [
          TextButton(
            child: const Text("Kamera"),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          TextButton(
            child: const Text("Galeri"),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadProfile() async {
    try {
      final data = await ref.read(authServiceProvider).fetchUserProfile();
      _firstName.text = data['first_name'] ?? '';
      _lastName.text = data['last_name'] ?? '';
      _username.text = data['username'] ?? '';
    } catch (e) {
      setState(() {
        _error = "Gagal memuat profil";
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isSaving = true;
      _error = null;
    });

    final success = await ref.read(authServiceProvider).updateProfile(
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          username: _username.text.trim(),
          password: _password.text.trim().isEmpty ? null : _password.text.trim(),
        );

    setState(() => _isSaving = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil berhasil diperbarui")),
      );
      Navigator.pop(context); // kembali ke ProfilePage
    } else {
      setState(() => _error = "Gagal memperbarui profil");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
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
                  blurRadius: 6,
                  offset: const Offset(0, 3),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const NetworkImage(
                          'https://via.placeholder.com/150/0000FF/808080?Text=Profile',
                        ) as ImageProvider,
                ),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
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
            CustomTextField(
              labelText: 'First Name',
              prefixIcon: Icons.person_outline,
              controller: _firstName,
              readOnly: false,
            ),
            sizedbox2,
            CustomTextField(
              labelText: 'Last Name',
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
              labelText: 'Password (opsional)',
              prefixIcon: Icons.lock_outline,
              controller: _password,
              obscureText: true,
              readOnly: false,
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 83),
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
                onPressed: _isSaving ? null : _saveProfile,
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save', style: headerblack),
              ),
            ),
            sizedbox3,
          ],
        ),
      ),
    );
  }
}
