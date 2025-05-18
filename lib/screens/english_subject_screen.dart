import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/letter_model.dart';
import 'letter_lesson_screen.dart';

class EnglishSubjectScreen extends StatefulWidget {
  const EnglishSubjectScreen({super.key});

  @override
  State<EnglishSubjectScreen> createState() => _EnglishSubjectScreenState();
}

class _EnglishSubjectScreenState extends State<EnglishSubjectScreen> {
  List<Letter> _letters = [];

  @override
  void initState() {
    super.initState();
    loadLetters();
  }

  Future<void> loadLetters() async {
    final String response = await rootBundle.loadString('assets/data/english_lessons.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _letters = data.map((e) => Letter.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('English Alphabet')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: _letters.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final letter = _letters[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LetterLessonScreen(letter: letter),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Center(
                  child: Text(
                    letter.letter,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}