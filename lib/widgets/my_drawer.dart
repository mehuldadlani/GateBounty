import 'package:flutter/material.dart';
import 'package:temp/auth_demo/auth_demo.dart';
import 'package:temp/auth_demo/auth_logic.dart';
import 'package:temp/screens/dao_page.dart';
import 'package:temp/screens/home_page.dart';
import 'package:temp/screens/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  void handleButtonPress(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AuthDemoPage()),
  );
  await AuthLogic.logout();
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffEDE9FE),
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "M A N G D A O",
                  style: TextStyle( fontSize: 30),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: const Text('DAOs', style: TextStyle(fontSize: 20),),
              onTap:(){
                Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => const HomePage()),  
  );  
              }
              
            ), 
             ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile', style: TextStyle(fontSize: 20),),
              onTap:(){
                Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => const ProfilePage()),  
  );  
              }
              
            ),  ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About', style: TextStyle(fontSize: 20),),
              onTap:(){
                Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => const DAOPage()),  
  );  
              }
              
            ), 
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout', style: TextStyle(fontSize: 20),),
              onTap:() => handleButtonPress(context),
            )
          ],
        )
      ),
    );
  }
}