import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:temp/auth_demo/auth_demo.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/particle.png', height: 100,),
        ],
      ),
      nextScreen: const AuthDemoPage(),
      splashIconSize: 100,
      duration: 1000,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}