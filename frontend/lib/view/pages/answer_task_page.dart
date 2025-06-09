import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/widgets/colors.dart';
import 'package:jam/view/widgets/text_template.dart';
import 'package:jam/view/widgets/custom_alert_dialog.dart';
import 'package:jam/viewmodels/answer_task_viewmodel.dart';
import 'package:jam/viewmodels/task_detail_viewmodel.dart';

class AnswerTaskPage extends ConsumerStatefulWidget {
  final String taskId;

  const AnswerTaskPage({super.key, required this.taskId});

  @override
  ConsumerState<AnswerTaskPage> createState() => _AnswerTaskPageState();
}

class _AnswerTaskPageState extends ConsumerState<AnswerTaskPage> {
  final _answerDescriptionController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _answerDescriptionController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskDetailViewModelProvider(widget.taskId));
    final answerState = ref.watch(answerTaskViewModelProvider(widget.taskId));
    final notifier = ref.read(
      answerTaskViewModelProvider(widget.taskId).notifier,
    );

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Answer Task')),
        body: const Center(child: Text('Task not found.')),
      );
    }

    _answerDescriptionController.text = answerState?.description ?? '';
    _commentController.text = answerState?.comment ?? '';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Answer: ${task.taskName}', style: headerblack4),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Details:', style: headerblack3),
            const SizedBox(height: 10),
            // Display Task Photo
            if (task.photoPath != null && task.photoPath!.isNotEmpty)
              Center(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(task.photoPath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Center(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            const SizedBox(height: 15),

            Text(
              'Difficulty: ${task.difficulty?.displayName ?? 'N/A'}',
              style: body1,
            ),
            Text(
              'Description: ${task.description ?? 'No description.'}',
              style: body1,
            ),
            const SizedBox(height: 30),

            Text('Your Answer:', style: headerblack3),
            const SizedBox(height: 10),
            // Answer Photo
            Center(
              child: InkWell(
                onTap: notifier.pickAnswerPhoto,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child:
                      answerState?.photoPath != null &&
                              answerState!.photoPath.isNotEmpty
                          ? Image.file(
                            File(answerState.photoPath),
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                          )
                          : const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text('Your Answer Description', style: headerblack3),
            const SizedBox(height: 8),
            TextField(
              controller: _answerDescriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Describe your answer',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.updateDescription,
            ),
            const SizedBox(height: 20),

            Text('Your Comment (Optional)', style: headerblack3),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add a comment',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.updateComment,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                ),
                onPressed: () async {
                  final success = await notifier.submitAnswer();
                  if (success) {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return CustomAlertDialog(
                          title: 'Answer Submitted!',
                          content:
                              'Your answer has been submitted. Points will be awarded once the task owner approves it.',
                          onConfirm: () {
                            Navigator.of(dialogContext).pop();
                          },
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please provide photo and description for your answer.',
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit Answer', style: headerblack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
