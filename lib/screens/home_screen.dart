import 'package:flutter/material.dart';
import 'english_subject_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset('assets/images/logo_brain.png', width: 120),
            const SizedBox(height: 16),
            const Text(
              'BrainBuddies',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('English', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  VerticalDivider(),
                  SizedBox(width: 8),
                  Text('العربية', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _SubjectButton(
              label: 'Math',
              icon: Icons.calculate,
              color: Colors.blue,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _SubjectButton(
              label: 'Science',
              icon: Icons.science,
              color: Colors.green,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _SubjectButton(
              label: 'English',
              icon: Icons.menu_book,
              color: Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EnglishSubjectScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _SubjectButton(
              label: 'Quizzes',
              icon: Icons.question_answer,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QuizScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SubjectButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}