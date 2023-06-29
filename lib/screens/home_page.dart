import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:temp/screens/about_page.dart';
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
    const DAOPage(),
    const ProfilePage(),
    const AboutPage()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
      color: Color(0xffEDE9FE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          textStyle: const TextStyle(color: Colors.black, ),
          backgroundColor: Color(0xffEDE9FE),
          activeColor: Colors.black,
          color: Colors.black,
          tabBackgroundColor: Colors.white,
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
              icon: Icons.person_2_outlined,
              text: "Profile",
            ),
            GButton(
              icon: Icons.info_outline,
              text: "About",
            ),
          ],
        ),
      ),
    )
    );
  }
}