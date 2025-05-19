import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';


class QuizScreen extends StatefulWidget {
  final String filePath;

  const QuizScreen({super.key, required this.filePath});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> 
{
  List<dynamic> questions = [];
  int currentIndex = 0;
  String? selectedOption;
  bool answered = false;
  int correctAnswers = 0; // ✅ Added
  final player = AudioPlayer();

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

  Future<void> loadQuiz() async 
  {
    final String content = await rootBundle.loadString(widget.filePath);
    final Map<String, dynamic> data = json.decode(content);
    setState(() {
      questions = data['questions'];
    });
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
      setState(() {
        if (currentIndex < questions.length - 1) {
          currentIndex++;
          selectedOption = null;
          answered = false;
       } else {
              saveQuizResult(correctAnswers, questions.length); // ✅ Save progress

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text("Quiz Complete"),
      content: Text("You answered $correctAnswers out of ${questions.length} correctly."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Go back to previous screen
          },
          child: const Text("Back"),
        )
      ],
    ),
  );
}

      });
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
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              q['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(q['options'].length, (index) {
  final option = q['options'][index];
  final isCorrect = option == q['answer'];
  final isSelected = option == selectedOption;

  Color? tileColor;
  if (answered) {
    tileColor = isCorrect
        ? Colors.green
        : isSelected
            ? Colors.red
            : null;
  }

  return AnimatedOpacity(
    duration: const Duration(milliseconds: 300),
    opacity: answered ? 1.0 : 1.0,
    child: Card(
      color: tileColor,
      child: ListTile(
        title: Text(option),
        onTap: answered ? null : () => checkAnswer(option),
      ),
    ),
  );
})
,
          ],
        ),
      ),
    );
  }
}
