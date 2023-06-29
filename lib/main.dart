import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:temp/screens/about_page.dart';
import 'package:temp/screens/home_page.dart';
import 'package:temp/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
      backgroundColor: Colors.black,
      animationCurve: Curves.easeIn,
      animationBuilder: const OffsetAnimationBuilder(),
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 5),
      child: MaterialApp(
        home: const SplashScreen(),
      ),
    );
  }
}

