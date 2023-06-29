
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:particle_auth/particle_auth.dart';
import 'package:temp/auth_demo/auth_logic.dart';
import 'package:temp/screens/home_page.dart';
import 'package:http/http.dart' as http;



class AuthDemoPage extends StatefulWidget {
  const AuthDemoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthDemoPageState();
  }
}

class AuthDemoPageState extends State<AuthDemoPage> {
  bool loginSuccess = false;

  @override
  initState() {
    super.initState();
    AuthLogic.setChain();
    AuthLogic.init(Env.dev);
  }

  Future<void> handleLogin() async {
    await AuthLogic.login();

    bool isLoggedIn = await AuthLogic.isLoginAsync();
    if (isLoggedIn) {
      Map<String, String> requestBody = {
       "publicKey": AuthLogic.evmPubAddress ?? '',
      };

      var url = Uri.parse('http://192.168.29.117:8080/createUser'); 
      var response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Login and POST request successful');
        print(response.body);

        setState(() {
          loginSuccess = true;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('Error in POST request: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("POST Request Failed"),
            content: const Text("Please try again."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } else {
      print('Login Unsuccessful');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Unsuccessful"),
          content: const Text("Please try again."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "L O G I N",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffE7E0D3),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Icon(
                  Icons.lock,
                  size: 150,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Login Using",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: height * 0.09,
              width: width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/particle.png',
                      height: 30,
                    ),
                    Text(
                      "Particle Network",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}