import 'package:flutter/material.dart';
import 'package:jam/colors.dart';

class TasklistPage extends StatelessWidget {
  const TasklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(child: Text("Add Task Page")),
    );
  }
}
