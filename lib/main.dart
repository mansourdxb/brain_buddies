import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // correct this path if needed
import 'screens/home_screen.dart';

void main() {
  runApp(const BrainBuddiesApp());
}

class BrainBuddiesApp extends StatelessWidget {
  const BrainBuddiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBuddies',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // ✅ Should be this
    );
  }
}

