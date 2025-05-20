import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  final String filePath;
  final String? title;
  final String? quizId;

  const QuizScreen({
    super.key,
    required this.filePath,
    this.title,
    this.quizId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> questions = [];
  int currentIndex = 0;
  String? selectedOption;
  bool answered = false;
  int correctAnswers = 0;
  final player = AudioPlayer();
  String? quizTitle;
  List<dynamic> quizList = [];

  Future<void> saveQuizResult(int correct, int total) async {
    final prefs = await SharedPreferences.getInstance();
    final quizId = widget.filePath.split('/').last.replaceAll('.json', '');

    await prefs.setInt('${quizId}_score', correct);
    await prefs.setInt('${quizId}_total', total);
    await prefs.setBool('${quizId}_completed', true);
  }

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    final content = await rootBundle.loadString(widget.filePath);
    final data = json.decode(content);
    quizList = data['quizzes'] as List;
    final quiz = quizList.firstWhere((q) => q['id'] == widget.quizId);

    setState(() {
      quizTitle = quiz['title'];
      questions = quiz['questions'];
    });
  }

  void goToNextQuiz() {
    final currentIndexInList = quizList.indexWhere((q) => q['id'] == widget.quizId);
    if (currentIndexInList != -1 && currentIndexInList + 1 < quizList.length) {
      final nextQuiz = quizList[currentIndexInList + 1];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizScreen(
            filePath: widget.filePath,
            quizId: nextQuiz['id'],
            title: nextQuiz['title'],
          ),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _handleQuizCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final quizKey = widget.filePath.split('/').last.replaceAll('.json', '');
    await prefs.setString('progress_$quizKey', '$correctAnswers/${questions.length}');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Complete"),
        content: Text("You answered $correctAnswers out of ${questions.length} correctly."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              goToNextQuiz();
            },
            child: const Text("Next Quiz"),
          ),
        ],
      ),
    );
  }

  void checkAnswer(String selected) async {
    final correct = questions[currentIndex]['answer'];

    if (selected == correct) {
      correctAnswers++;
      await player.play(AssetSource('sounds/correct.mp3'));
    } else {
      await player.play(AssetSource('sounds/wrong.mp3'));
    }

    setState(() {
      selectedOption = selected;
      answered = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedOption = null;
          answered = false;
        });
      } else {
        _handleQuizCompletion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Quiz'),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F7FA), Color(0xFFE6EEFA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q['question'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(q['options'].length, (index) {
              final option = q['options'][index];
              final isCorrect = option == q['answer'];
              final isSelected = option == selectedOption;

              Color? cardColor;
              if (answered) {
                cardColor = isCorrect
                    ? Colors.green.shade100
                    : isSelected
                        ? Colors.red.shade100
                        : Colors.white;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: cardColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  title: Text(option),
                  onTap: answered ? null : () => checkAnswer(option),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
