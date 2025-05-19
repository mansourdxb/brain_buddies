import 'package:flutter/material.dart';

class LessonTile extends StatelessWidget {
  final String title;
  final String? type;        // e.g., "Lesson", "Quiz"
  final IconData? icon;      // optional icon
  final VoidCallback onTap;

  const LessonTile({
    Key? key,
    required this.title,
    this.type,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: icon != null ? Icon(icon, size: 32) : null,
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: type != null ? Text(type!) : null,
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
