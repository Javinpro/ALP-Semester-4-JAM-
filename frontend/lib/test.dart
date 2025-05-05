// ini hanya test page, tidak usah diperhatikan
// - Aryo

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FloatingBottomBar());
  }
}

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({super.key});

  @override
  FloatingBottomBarState createState() =>
      FloatingBottomBarState();
}

class FloatingBottomBarState extends State<FloatingBottomBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

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
      // margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            )
          : null,
      child: Center(
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home,
      Icons.search,
      Icons.notifications,
      Icons.favorite,
      Icons.person
    ];

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: const [
          Center(child: Text("Home Page")),
          Center(child: Text("Search Page")),
          Center(child: Text("Notifications Page")),
          Center(child: Text("Favorites Page")),
          Center(child: Text("Profile Page")),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 12,
          borderRadius: BorderRadius.circular(15),
          shadowColor: Colors.black.withOpacity(0.40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BottomAppBar(
              color: Colors.white,
              child: SizedBox(
                height: 60,
                child: Row(
                  children: List.generate(icons.length, (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _onTap(index),
                        behavior: HitTestBehavior.opaque,
                        child: _buildNavItem(icons[index], index),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
