import 'package:flutter/material.dart';
import 'english_lessons_screen.dart';

class SubjectScreen extends StatelessWidget {
  final String selectedGrade;

  const SubjectScreen({super.key, required this.selectedGrade});

  @override
  Widget build(BuildContext context) {
    final List<String> subjects = ['English', 'Math', 'Science'];

    return Scaffold(
      appBar: AppBar(title: Text('Subjects – $selectedGrade')),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return ListTile(
            title: Text(subject),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              if (subject == 'English') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EnglishLessonsScreen(selectedGrade: selectedGrade),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$subject lessons coming soon...')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
