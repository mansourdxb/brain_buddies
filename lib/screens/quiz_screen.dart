import 'package:flutter/material.dart';
import 'results_screen.dart';

class QuizScreen extends StatelessWidget {
  final String subject;
  final int quizNumber;

  const QuizScreen({super.key, required this.subject, required this.quizNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$subject Quiz $quizNumber')),
      body: Center(
        child: ElevatedButton(
          child: Text('Complete Quiz'),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultsScreen(score: 80)));
          },
        ),
      ),
    );
  }
}
