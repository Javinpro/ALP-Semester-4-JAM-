import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';
import '../widgets/fab.dart';

class TasklistPage extends StatelessWidget {
  const TasklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Text("Add Task Page")),
      floatingActionButton: const AddItemFAB(),
    );
  }
}
