import 'package:flutter/material.dart';
import 'package:temp/auth_demo/auth_demo.dart';
import 'package:temp/auth_demo/auth_logic.dart';
import 'package:temp/screens/dao_page.dart';

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
        color: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "L O G O",
                  style: TextStyle( fontSize: 35),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: const Text('DAOs', style: TextStyle(fontSize: 20),),
              onTap:(){
                Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => const DaoPage()),  
  );  
              }
            ), ListTile(
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