import 'package:flutter/material.dart';
import 'subjects_screen.dart';

class GradeSelectionScreen extends StatelessWidget {
  final List<String> grades = [
    'FS1',
    'FS2',
    'Year 1',
    'Year 2',
    'Year 3',
    'Year 4',
    'Year 5',
    'Year 6',
  ];

  final List<IconData> icons = [
    Icons.child_care,
    Icons.child_friendly,
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
    Icons.looks_5,
    Icons.looks_6,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Select Your Grade'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEB71), Color(0xFFF8D800)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: grades.length,
          padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 24),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(icons[index], color: Colors.white),
                ),
                title: Text(
                  grades[index],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SubjectsScreen(selectedGrade: grades[index]),
                    ),
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
