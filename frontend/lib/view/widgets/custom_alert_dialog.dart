import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart'; // Sesuaikan
import 'package:jam/view/utils/text_template.dart'; // Sesuaikan

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String confirmButtonText;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmButtonText = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(title, style: headerblack4, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content, style: body1, textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onConfirm,
            child: Text(confirmButtonText, style: headerblack),
          ),
        ),
      ],
    );
  }
}
