import 'package:flutter/material.dart';
import 'package:jam/view/widgets/task_swipe_card.dart';
import 'package:jam/view/widgets/todo_swipe_card.dart';
import 'package:provider/provider.dart';
import 'package:jam/viewmodels/task_tab_viewmodel.dart';
import 'package:jam/view/widgets/task_card.dart';
import 'package:jam/view/utils/colors.dart';
import '../widgets/fab.dart';

class TasklistPage extends StatelessWidget {
  const TasklistPage({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => TaskTabViewModel()..fetchTasks(),
      child: Consumer<TaskTabViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleButton(
                        title: 'Task',
                        selected: vm.currentTab == TaskTab.task,
                        onTap: () => vm.switchTab(TaskTab.task),
                      ),
                      const SizedBox(width: 12),
                      ToggleButton(
                        title: 'To Do',
                        selected: vm.currentTab == TaskTab.todo,
                        onTap: () => vm.switchTab(TaskTab.todo),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: vm.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : vm.tasks.isEmpty
                            ? const Center(
                                child: Text(
                                  'No task listed',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: vm.tasks.length,
                                itemBuilder: (context, index) {
                                  final task = vm.tasks[index];
                                  return vm.currentTab == TaskTab.todo
                                      ? TodoSwipeCard(task: task, onUpdated: () => vm.fetchTasks())
                                      : TaskSwipeCard(task: task, onUpdated: () => vm.fetchTasks());
                                },
                              ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
//    return Scaffold(
//      backgroundColor: backgroundColor,
//      body: Center(child: Text("Add Task Page")),
//      floatingActionButton: const AddItemFAB(),

    );
  }
}
