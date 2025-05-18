import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class SubjectsScreen extends StatelessWidget {
  final String subject;
  const SubjectsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: ListView.builder(
        itemCount: 5, // Example lessons/quizzes
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.quiz),
            title: Text('$subject Quiz ${index + 1}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(subject: subject, quizNumber: index + 1)));
            },
          );
        },
      ),
    );
  }
}
