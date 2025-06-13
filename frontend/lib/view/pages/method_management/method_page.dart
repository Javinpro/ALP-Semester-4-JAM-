// view/pages/method_management/method_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/pages/method_management/detail_method/Metode_52-17.dart';
import 'package:jam/view/pages/method_management/detail_method/Ultradian_Rhythm.dart';
import 'package:jam/view/pages/method_management/detail_method/pomodoro.dart';
import 'package:jam/view/pages/notification.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/viewmodels/method_list_viewmodel.dart'; // Import ViewModel

class MethodPage extends ConsumerWidget {
  const MethodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(
      methodListViewModelProvider,
    ); // Watch filtered methods
    final viewModel = ref.read(
      methodListViewModelProvider.notifier,
    ); // Access the ViewModel

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Method Page', style: headerblack4),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20.0, top: 10.0),
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              radius: 30,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: backgroundColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.1,
                    ), // Shadow color and opacity
                    spreadRadius: 1, // How much the shadow spreads
                    blurRadius: 5, // How blurred the shadow is
                    offset: const Offset(0, 5), // Offset of the shadow
                  ),
                ],
              ),
              child: TextField(
                onChanged: (query) {
                  viewModel.filterMethods(
                    query,
                  ); // Call filter method on ViewModel
                },
                decoration: InputDecoration(
                  hintText: 'Search methods...',
                  hintStyle: headergrey2,
                  prefixIcon: Padding(
                    // Wrap the icon in Padding to give some space
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      // Wrap the icon with CircleAvatar
                      backgroundColor:
                          secondaryColor, // Set the background color for the circle
                      child: const Icon(
                        Icons.search,
                        color: primaryColor, // Set icon color for contrast
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 120.0),
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                Widget detailPage;
                // Determine the appropriate detail page based on method ID
                if (method.id == 'pomodoro') {
                  detailPage = PomodoroDetailPage(
                    title: method.title,
                    title2: method.title2,
                    title3: method.title3,
                    imagePath: method.imagePath,
                  );
                } else if (method.id == 'metode_52_17') {
                  detailPage = Metode5217Page(
                    title: method.title,
                    title2: method.title2,
                    title3: method.title3,
                    imagePath: method.imagePath,
                  );
                } else if (method.id == 'ultradian_rhythm') {
                  detailPage = UltradianRhythmPage(
                    title: method.title,
                    title2: method.title2,
                    title3: method.title3,
                    imagePath: method.imagePath,
                  );
                } else {
                  detailPage = const Text('Unknown Method'); // Fallback
                }

                return MethodCard(
                  imagePath: method.imagePath,
                  title: method.title,
                  description:
                      method.title2, // Using title2 as a short description
                  detailPage: detailPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// MethodCard (No changes needed, already a StatelessWidget)
class MethodCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget detailPage;

  const MethodCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.detailPage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      color: backgroundColor,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 300,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.error,
                        size: 100,
                      ), // Placeholder error
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(title, style: headerblack),
            const SizedBox(height: 8.0),
            Text(description, style: headergrey2),
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => detailPage),
                    );
                  },
                  child: const Text('Lihat detail', style: headerblack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
