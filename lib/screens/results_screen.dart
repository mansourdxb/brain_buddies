import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  const ResultsScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Results')),
      body: Center(
        child: Text('Your score is: $score%', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
