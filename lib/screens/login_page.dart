import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Welcome to Flutter', style: TextStyle(color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
    );
  }
}