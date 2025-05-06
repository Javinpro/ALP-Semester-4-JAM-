import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        leading: BackButton(),
      ),
      body: const Center(
        child: Text('page untuk add task'),
      ),
    );
  }
}
