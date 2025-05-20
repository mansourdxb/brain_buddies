import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class LessonViewerScreen extends StatefulWidget {
  final String filePath;
  final String lessonId;
  final String? title;

  const LessonViewerScreen({
    super.key,
    required this.filePath,
    required this.lessonId,
    this.title,
  });

  @override
  State<LessonViewerScreen> createState() => _LessonViewerScreenState();
}

class _LessonViewerScreenState extends State<LessonViewerScreen> {
  String lessonTitle = '';
  List<dynamic> lessonContent = [];

  @override
  void initState() {
    super.initState();
    loadLesson();
  }

  Future<void> loadLesson() async {
    final content = await rootBundle.loadString(widget.filePath);
    final data = json.decode(content);
    final lessons = data['lessons'] as List;
    final lesson = lessons.firstWhere((l) => l['id'] == widget.lessonId);

    setState(() {
      lessonTitle = lesson['title'];
      lessonContent = lesson['content'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lessonTitle.isNotEmpty ? lessonTitle : 'Lesson')),
      body: lessonContent.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: lessonContent.length,
              itemBuilder: (context, index) {
                final item = lessonContent[index];
                if (item['type'] == 'text') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item['value'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (item['type'] == 'image') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset(item['value']),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
    );
  }
}
