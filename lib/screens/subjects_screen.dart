import 'package:flutter/material.dart';
import 'english_lessons_screen.dart';
import 'math_lessons_screen.dart';
// import 'science_lessons_screen.dart'; // for future

class SubjectsScreen extends StatelessWidget {
  final String selectedGrade;

  const SubjectsScreen({super.key, required this.selectedGrade});

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
            leading: Icon(Icons.book),
            title: Text(subject),
            onTap: () {
              if (subject == 'English') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EnglishLessonsScreen(selectedGrade: selectedGrade),
                  ),
                );
              } else if (subject == 'Math') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MathLessonsScreen(selectedGrade: selectedGrade),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$subject not implemented yet')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
