import 'package:flutter/material.dart';
import 'colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Notifikasi'),
        leading: BackButton(),
      ),
      body: const Center(
        child: Text('edit page ini untuk notifikasi syg'),
      ),
    );
  }
}

//                     _   _   
//                    | | | |  
//    __ _ _   _  __ _| |_| |_ 
//   / _` | | | |/ _` | __| __|
//  | (_| | |_| | (_| | |_| |_ 
//   \__, |\__, |\__,_|\__|\__|
//    __/ | __/ |              
//   |___/ |___/               