import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:temp/auth_demo/auth_demo.dart';
import 'package:temp/screens/dao_page.dart';
import 'package:temp/screens/profile_page.dart';
import 'package:temp/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _pages =[
    const DaoPage(),
    const AuthDemoPage(),
    ProfilePage(),
    const DaoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // drawer: MyDrawer(),
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          activeColor: Colors.white,
          color: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
          gap: 8,
          padding: const EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "DAOs",
            ),
            GButton(
              icon: Icons.shopping_bag_outlined,
              text: "Shop",
            ),
            GButton(
              icon: Icons.person_2_outlined,
              text: "Profile",
            ),
            GButton(
              icon: Icons.settings_outlined,
              text: "About",
            ),
          ],
        ),
      ),
    )
    );
  }
}