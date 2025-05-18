import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'subjects_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BrainBuddies')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _subjectCard('math'.tr, Icons.calculate),
          _subjectCard('science'.tr, Icons.science),
          _subjectCard('english'.tr, Icons.menu_book),
        ],
      ),
    );
  }

  Widget _subjectCard(String subject, IconData icon) {
    return GestureDetector(
      onTap: () {
        Get.to(SubjectsScreen(subject: subject));
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(subject, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
