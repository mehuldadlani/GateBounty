import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:particle_auth/particle_auth.dart';
import 'package:temp/auth_demo/auth_logic.dart';
import 'package:temp/screens/dao_page.dart';
import 'package:temp/screens/home_page.dart';

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

void handleLogin() async {
  await AuthLogic.login();

  bool isLoggedIn = await AuthLogic.isLoginAsync();
  if (isLoggedIn) {
    setState(() {
      loginSuccess = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login Unsuccessful"),
        content: Text("Please try again."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("OK"),
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
                onPressed: () => handleLogin(),
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

