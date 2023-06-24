import 'package:flutter/material.dart';
import 'package:particle_auth/particle_auth.dart';
import 'package:temp/auth_demo/auth_logic.dart';

class AuthDemoPage extends StatefulWidget {
  const AuthDemoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthDemoPageState();
  }
}

class AuthDemoPageState extends State<AuthDemoPage> {

  @override
   initState() {
    super.initState();
    AuthLogic.setChain();
    AuthLogic.init(Env.dev);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.login()},
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.isLogin()},
                    child: const Text(
                      "IsLogin",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.isLoginAsync()},
                    child: const Text(
                      "IsLoginAsync",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.getAddress()},
                    child: const Text(
                      "Get Address",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.getUserInfo()},
                    child: const Text(
                      "Get UserInfo",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => {AuthLogic.logout()},
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}