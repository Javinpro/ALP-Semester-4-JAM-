import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon; // Tambahkan properti suffixIcon
  final VoidCallback?
  onSuffixIconTap; // Tambahkan callback untuk tap pada suffixIcon

  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: secondaryColor,
            width: 3.0,
          ), // Border saat tidak fokus
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: secondaryColor,
            width: 2.0,
          ), // Border saat fokus (warna tetap hitam)
        ),
      ),
    );
  }
}
