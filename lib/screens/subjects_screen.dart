import 'package:flutter/material.dart';
import 'english_lessons_screen.dart';
import 'math_lessons_screen.dart';
import 'science_lessons_screen.dart'; // Create a placeholder if not added

class SubjectsScreen extends StatelessWidget {
  final String selectedGrade;

  const SubjectsScreen({super.key, required this.selectedGrade});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subjects = [
      {
        'name': 'English',
        'icon': Icons.book,
        'color': Colors.blueAccent,
        'screen': EnglishLessonsScreen(selectedGrade: selectedGrade),
      },
      {
        'name': 'Math',
        'icon': Icons.calculate,
        'color': Colors.green,
        'screen': MathLessonsScreen(selectedGrade: selectedGrade),
      },
      {
        'name': 'Science',
        'icon': Icons.science,
        'color': Colors.deepPurple,
        'screen': ScienceLessonsScreen(selectedGrade: selectedGrade),
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Subjects – $selectedGrade'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFE0F2F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 24),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                leading: CircleAvatar(
                  backgroundColor: subject['color'],
                  child: Icon(subject['icon'], color: Colors.white),
                ),
                title: Text(
                  subject['name'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => subject['screen']),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
