import 'package:flutter/material.dart';
import 'package:jam/models/task.dart';
import 'package:jam/viewmodels/edit_task_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatelessWidget {
  final Task task;
  final Function()? onUpdated;

  const EditTaskPage({super.key, required this.task, this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditTaskViewModel()..initialize(task),
      child: Consumer<EditTaskViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Edit Task', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
            ),
            body: Form(
              key: vm.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Text('Task Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: vm.titleController,
                      validator: (val) => val == null || val.isEmpty ? 'Tidak boleh kosong' : null,
                      decoration: inputDecoration(),
                    ),
                    const SizedBox(height: 20),
                    const Text('Deadline', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: vm.selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) vm.setDate(picked);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: inputDecoration(),
                                controller: TextEditingController(
                                  text: vm.selectedDate != null
                                      ? DateFormat('dd - MM - yyyy').format(vm.selectedDate!)
                                      : '',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: vm.selectedTime ?? TimeOfDay.now(),
                              );
                              if (picked != null) vm.setTime(picked);
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: inputDecoration(),
                                controller: TextEditingController(
                                  text: vm.selectedTime?.format(context) ?? '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: vm.descriptionController,
                      maxLines: 5,
                      decoration: inputDecoration(),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: vm.isSaving
                          ? null
                          : () async {
                              final success = await vm.submit(task.id);
                              if (success && context.mounted) {
                                onUpdated?.call();
                                Navigator.pop(context);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Save'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );
}
