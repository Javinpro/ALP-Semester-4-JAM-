import 'package:flutter/material.dart';
import 'package:jam/colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(child: Text("Dashboard Page")),
    );
  }
}
