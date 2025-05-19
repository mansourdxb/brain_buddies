import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class LessonViewerScreen extends StatefulWidget {
  final String filePath;

  const LessonViewerScreen({super.key, required this.filePath});

  @override
  State<LessonViewerScreen> createState() => _LessonViewerScreenState();
}

class _LessonViewerScreenState extends State<LessonViewerScreen> {
  Map<String, dynamic>? lesson;

  @override
  void initState() {
    super.initState();
    loadLessonContent();
  }

  Future<void> loadLessonContent() async {
    final String content = await rootBundle.loadString(widget.filePath);
    setState(() {
      lesson = json.decode(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson?['title'] ?? 'Lesson')),
      body: lesson == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                lesson!['content'] ?? '',
                style: const TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
