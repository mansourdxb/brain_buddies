import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('welcome'.tr, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(Locale('en', 'US'));
              Get.to(HomeScreen());
            },
            child: Text('English'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(Locale('ar', 'SA'));
              Get.to(HomeScreen());
            },
            child: Text('العربية'),
          ),
        ],
      ),
    );
  }
}
