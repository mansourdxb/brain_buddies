import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // update path if needed

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/splash.png',
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
