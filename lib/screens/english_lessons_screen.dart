import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../widgets/lesson_tile.dart';



import 'lesson_viewer_screen.dart';

class EnglishLessonsScreen extends StatefulWidget {
  final String selectedGrade;

  const EnglishLessonsScreen({Key? key, required this.selectedGrade}) : super(key: key);

  @override
  State<EnglishLessonsScreen> createState() => _EnglishLessonsScreenState();
}

class _EnglishLessonsScreenState extends State<EnglishLessonsScreen> {
  List<dynamic> lessons = [];

  @override
  void initState() {
    super.initState();
    loadLessonsIndex();
  }

  Future<void> loadLessonsIndex() async {
    final String indexPath = 'assets/lessons/english/${widget.selectedGrade.toLowerCase()}/index.json';
    final String jsonStr = await rootBundle.loadString(indexPath);
    setState(() {
      lessons = json.decode(jsonStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("English – ${widget.selectedGrade}")),
      body: lessons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
 return LessonTile(
  title: lesson['title'],
  type: lesson['type'],  // should exist in index.json
  icon: lesson['type'] == 'Quiz' ? Icons.quiz : Icons.menu_book,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonViewerScreen(
          filePath: 'assets/lessons/english/${widget.selectedGrade.toLowerCase()}/${lesson['file']}',
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
