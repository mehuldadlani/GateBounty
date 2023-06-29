import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:temp/auth_demo/auth_demo.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Text("G A T E    B O U N T Y", style: TextStyle(fontSize: 30, fontFamily: GoogleFonts.poppins().fontFamily),),
        ],
      ),
      nextScreen: const AuthDemoPage(),
      splashIconSize: 100,
      duration: 1000,
      backgroundColor: Color(0xffEDE9FE),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}