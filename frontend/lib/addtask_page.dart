import 'package:flutter/material.dart';
import 'colors.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Add Task'),
        leading: BackButton(),
      ),
      body: const Center(
        child: Text('page untuk add task'),
      ),
    );
  }
}
