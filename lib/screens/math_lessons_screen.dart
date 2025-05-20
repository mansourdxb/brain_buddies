import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../widgets/lesson_tile.dart';
import 'lesson_viewer_screen.dart';
import 'quiz_screen.dart';

class MathLessonsScreen extends StatefulWidget {
  final String selectedGrade;

  const MathLessonsScreen({super.key, required this.selectedGrade});

  @override
  State<MathLessonsScreen> createState() => _MathLessonsScreenState();
}

class _MathLessonsScreenState extends State<MathLessonsScreen> {
  List<dynamic> lessons = [];

  @override
  void initState() {
    super.initState();
    loadLessonsIndex();
  }

  Future<void> loadLessonsIndex() async {
    final String indexPath = 'assets/lessons/math/${widget.selectedGrade.toLowerCase()}/index.json';
    final String jsonStr = await rootBundle.loadString(indexPath);
    setState(() {
      lessons = json.decode(jsonStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Math – ${widget.selectedGrade}")),
      body: lessons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final path = 'assets/lessons/math/${widget.selectedGrade.toLowerCase()}/${lesson['file']}';

                return LessonTile(
                  title: lesson['title'],
                  type: lesson['type'],
                  icon: lesson['type'] == 'Quiz' ? Icons.calculate : Icons.functions,
                  onTap: () {
                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => LessonViewerScreen(
      filePath: 'assets/lessons/math/year1/lessons.json',
      lessonId: lesson['lessonId'], // ✅ required
      title: lesson['title'],
    ),
  ),
);

                  },
                );
              },
            ),
    );
  }
}
