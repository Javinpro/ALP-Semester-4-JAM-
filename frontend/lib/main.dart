// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('JAM (WIP)'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'colors.dart';

import 'addtask_page.dart'; // page untuk tambah task ke task list
import 'dashboard_page.dart'; // page untuk dashboard
import 'tasklist_page.dart'; // page untuk liat list task
import 'taskpost_page.dart'; // page untuk posting task
import 'method_page.dart'; // page untuk alarm finder
import 'profile_page.dart'; // page untuk profile

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FloatingBottomBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({super.key});

  @override
  FloatingBottomBarState createState() => FloatingBottomBarState();
}

class FloatingBottomBarState extends State<FloatingBottomBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    DashboardPage(),
    TasklistPage(),
    TaskpostPage(),
    MethodPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = index == _currentIndex;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ), // Added margin here
      decoration:
          isSelected
              ? BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              )
              : null,
      child: Center(child: Icon(icon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home,
      Icons.list_alt,
      Icons.content_paste,
      Icons.timer,
      Icons.person,
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: _pages,
          ),
          Positioned(
            bottom: 125, // adjust to raise above bottom bar
            right: 16, // adjust for horizontal position
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddItemPage()),
                );
              },
              backgroundColor: secondaryColor,
              shape: CircleBorder(),
              child: const Icon(Icons.add, color: primaryColor),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 24,
          borderRadius: BorderRadius.circular(15),
          shadowColor: Colors.black.withValues(alpha: .4),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: List.generate(icons.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ), // Additional padding wrapper
                    child: GestureDetector(
                      onTap: () => _onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: _buildNavItem(icons[index], index),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
