import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quiz_model.dart';
import 'result_screen.dart';




class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response = await rootBundle.loadString('assets/data/english_quiz.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _questions = data.map((e) => QuizQuestion.fromJson(e)).toList();
      _questions.shuffle();
    });
  }

  void handleAnswer(String selected) {
    if (_questions[_currentIndex].correct == selected) {
      _score++;
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(score: _score, total: _questions.length)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];
    final List<String> shuffledOptions = List.from(question.options)..shuffle();

    return Scaffold(
      appBar: AppBar(title: Text('Question ${_currentIndex + 1}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...shuffledOptions.map((opt) => GestureDetector(
                  onTap: () => handleAnswer(opt),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        opt,
                        width: 200,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}