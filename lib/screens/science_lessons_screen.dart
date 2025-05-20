import 'package:flutter/material.dart';

class ScienceLessonsScreen extends StatelessWidget {
  final String selectedGrade;

  const ScienceLessonsScreen({super.key, required this.selectedGrade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Science – $selectedGrade')),
      body: const Center(
        child: Text('Science lessons will be added soon.'),
      ),
    );
  }
}
