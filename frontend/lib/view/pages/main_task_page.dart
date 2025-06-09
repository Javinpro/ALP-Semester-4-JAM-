import 'package:flutter/material.dart';
import 'package:jam/view/widgets/colors.dart'; // Sesuaikan
import 'package:jam/view/widgets/text_template.dart'; // Sesuaikan
import 'package:jam/view/pages/doing_tasks_page.dart';
import 'package:jam/view/pages/posted_tasks_page.dart';

class MainTaskPage extends StatefulWidget {
  const MainTaskPage({super.key});

  @override
  State<MainTaskPage> createState() => _MainTaskPageState();
}

class _MainTaskPageState extends State<MainTaskPage> {
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
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          _selectedIndex == 0 ? 'Posted Tasks' : 'Doing Tasks',
          style: headerblack4,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onItemTapped(0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedIndex == 0 ? primaryColor : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Posted',
                      style:
                          _selectedIndex == 0
                              ? headerblack
                              : body1.copyWith(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onItemTapped(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedIndex == 1 ? primaryColor : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Doing',
                      style:
                          _selectedIndex == 1
                              ? headerblack
                              : body1.copyWith(color: Colors.black54),
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
