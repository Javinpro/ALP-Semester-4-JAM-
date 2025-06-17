// import 'package:flutter/material.dart';

// class MyFloatingActionBtn extends StatelessWidget {
//   final VoidCallback onPressed;

//   const MyFloatingActionBtn({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: onPressed,
//       child: Icon(Icons.add),
//     );
//   }
// }

// add_item_fab.dart
import 'package:flutter/material.dart';
import '../pages/addtask_page.dart';
import '../utils/colors.dart'; // <- where secondaryColor and primaryColor are defined

class AddItemFAB extends StatelessWidget {
  const AddItemFAB({super.key});

// You can optionally add parameters if you want more flexibility
// (like bottom, right, or onPressed)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 125, right: 16),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemPage()),
          );
        },
        backgroundColor: secondaryColor,
        shape: const CircleBorder(), // or CircleBorder()
        child: const Icon(Icons.add, color: primaryColor),
      ),
    );
  }
}

