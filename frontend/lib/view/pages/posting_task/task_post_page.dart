import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart'; // Sesuaikan
import 'package:jam/view/utils/text_template.dart'; // Sesuaikan
import 'package:jam/view/pages/posting_task/doing_tasks_page.dart';
import 'package:jam/view/pages/posting_task/posted_tasks_page.dart';

class TaskpostPage extends StatefulWidget {
  const TaskpostPage({super.key});

  @override
  State<TaskpostPage> createState() => _TaskpostPageState();
}

class _TaskpostPageState extends State<TaskpostPage> {
  int _selectedIndex = 0; // 0 for Posted, 1 for Doing

  static const List<Widget> _pages = <Widget>[
    PostedTasksPage(),
    DoingTasksPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          sizedbox11,
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onItemTapped(0),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 18, bottom: 18),
                      backgroundColor:
                          _selectedIndex == 0
                              ? secondaryColor
                              : backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Posted',
                      style: _selectedIndex == 0 ? headerwhite : headerblack,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onItemTapped(1),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 18, bottom: 18),

                      backgroundColor:
                          _selectedIndex == 1
                              ? secondaryColor
                              : backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Doing',
                      style: _selectedIndex == 1 ? headerwhite : headerblack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
