import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/letter_model.dart';

class LetterLessonScreen extends StatelessWidget {
  final Letter letter;
  const LetterLessonScreen({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    return Scaffold(
      appBar: AppBar(title: Text('Letter ${letter.letter}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              letter.letter,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              letter.word,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Image.asset(
              letter.image,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await flutterTts.setLanguage("en-US");
                await flutterTts.setPitch(1.0);
                await flutterTts.speak("${letter.letter} for ${letter.word}");
              },
              icon: const Icon(Icons.volume_up),
              label: const Text('Hear Pronunciation'),
            )
          ],
        ),
      ),
    );
  }
}
