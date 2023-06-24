import 'package:flutter/material.dart';
import 'package:temp/screens/dao_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "L O G O",
                  style: TextStyle( fontSize: 35),
                ),
              ),
            ),ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: const Text('DAOs', style: TextStyle(fontSize: 20),),
              onTap:(){
                Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => DaoPage()),  
  );  
              }
            )
          ],
        )
      ),
      // child: ListView(
      //   padding: EdgeInsets.zero,
      //   children: [
      //     UserAccountsDrawerHeader(
      //       accountName: const Text('Mehul Dadlani'),
      //       accountEmail: const Text('mehuldadlani13@gmail.com'),
      //       currentAccountPicture: CircleAvatar(
      //         child: ClipOval(
      //           child: Image.asset(
      //             'assets/avatar.png',
      //             fit: BoxFit.cover,
      //             width: 90,
      //             height: 90,
      //           ),
      //         ),
      //       ),
      //       decoration: const BoxDecoration(
      //         color: Colors.black,
      //         image: DecorationImage(
      //             fit: BoxFit.fill,
      //             image: NetworkImage(
      //                 'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
      //       ),
      //     ),
      //      ListTile(
      //       leading: const Icon(Icons.attach_money,),
      //       title: Row(children: [Text(
      //       'Earn',
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontFamily: 'Roboto',
      //         foreground: Paint()
      //           ..shader = const LinearGradient(
      //             colors: [
      //               Color.fromRGBO(111, 88, 219, 1.0), // #6F58DB
      //               Color.fromRGBO(229, 110, 132, 1.0), // #E56E84
      //             ],
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
      //       ),
      //     ),]),
      //       onTap: () {
      //         // Navigator.push(
      //         //   context,
      //         // MaterialPageRoute(builder: ((context) { return EarnPage();})));
      //       },
      //     ),
      //     const Divider(),
      //     ListTile(
      //       leading: const Icon(Icons.dashboard),
      //       title: const Text('Dashboard',style: TextStyle(
      //         fontSize: 20)),
      //       onTap: () {},
      //     ),
      //     ListTile(
      //       leading: const Icon(Icons.settings),
      //       title: const Text('Settings',style: TextStyle(
      //         fontSize: 20)),
      //      onTap: () {},
      //     ),
      //     ListTile(
      //       leading: const Icon(Icons.description),
      //       title: const Text('Policies',style: TextStyle(
      //         fontSize: 20)),
      //       onTap: () {},
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text('LogOut',style: TextStyle(
      //         fontSize: 20)),
      //       leading: const Icon(Icons.logout),
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //     ListTile(
      //       title: const Text('Exit',style: TextStyle(
      //         fontSize: 20)),
      //       leading: const Icon(Icons.exit_to_app),
      //       onTap: () {},
      //     ),
      //   ],
      // ),
    );
  }
}