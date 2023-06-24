import 'package:flutter/material.dart';
import 'package:temp/auth_demo/auth_logic.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;
  bool isLoading = true;
  bool showFullAddress = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await AuthLogic.isLoginAsync();
    if (isLoggedIn) {
      setState(() {
        currentUser = AuthLogic.currentUser;
        isLoading = false;
      });
    } else {
      // User is not logged in, trigger the login process
      await AuthLogic.login();
      setState(() {
        currentUser = AuthLogic.currentUser;
        isLoading = false;
      });
    }
  }

  void toggleAddressVisibility() {
    setState(() {
      showFullAddress = !showFullAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        title: const Text(
          'P R O F I L E',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffE7E0D3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator() // Show loading indicator while fetching user data
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      Center(
                          child: Image.asset("assets/image4.png",
                              height: height * 0.25)),
                              SizedBox(height: height * 0.02),
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                       "-> ${currentUser?.phone ?? ''}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      const Text(
                        "Chain Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "-> ${AuthLogic.chainName ?? ''}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                       SizedBox(height: height * 0.02),
                      const Text(
                        "Public Address",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      InkWell(
                        onTap: toggleAddressVisibility,
                        child: Row(
                          children: [
                            Visibility(
                              visible: !showFullAddress,
                              child: Expanded(
                                child: Text(
                                  '**********',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: showFullAddress,
                              child: Expanded(
                                child: Text(
                                  "-> ${AuthLogic.evmPubAddress ?? ''}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Icon(Icons.visibility),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}