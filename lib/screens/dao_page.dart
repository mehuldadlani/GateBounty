import 'package:flutter/material.dart';
import 'package:temp/widgets/my_drawer.dart';

class DaoPage extends StatefulWidget {
  const DaoPage({Key? key}) : super(key: key);

  @override
  _DaoPageState createState() => _DaoPageState();
}

class _DaoPageState extends State<DaoPage> {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      drawer: const MyDrawer() ,
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        backgroundColor: const Color(0xffE7E0D3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "D  A  O",
          style: TextStyle(color: Colors.black,fontSize: 25)
        ),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height*0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F0E0),
                ),
                height: height*0.2,
                width: width*0.9,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                      ),
                      width: width*0.3,
                      padding: const EdgeInsets.all(10),
                      height: height*0.2,
                      child: Image.asset("assets/doge.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Column(
                        children: [
                          Text("Doge DAO", style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Text(" Doge DAO is a \n community driven\n DAO \n . . . .", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(onPressed: (){}, child: Text("Enter", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            ),SizedBox(
              height: height*0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F0E0),
                ),
                height: height*0.2,
                width: width*0.9,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                      ),
                      width: width*0.3,
                      padding: const EdgeInsets.all(10),
                      height: height*0.2,
                      child: Image.asset("assets/doge.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Column(
                        children: [
                          Text("Doge DAO", style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Text(" Doge DAO is a \n community driven\n DAO \n . . . .", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(onPressed: (){}, child: Text("Enter", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height*0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F0E0),
                ),
                height: height*0.2,
                width: width*0.9,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                      ),
                      width: width*0.3,
                      padding: const EdgeInsets.all(10),
                      height: height*0.2,
                      child: Image.asset("assets/doge.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Column(
                        children: [
                          Text("Doge DAO", style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Text(" Doge DAO is a \n community driven\n DAO \n . . . .", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(onPressed: (){}, child: Text("Enter", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height*0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F0E0),
                ),
                height: height*0.2,
                width: width*0.9,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                      ),
                      width: width*0.3,
                      padding: const EdgeInsets.all(10),
                      height: height*0.2,
                      child: Image.asset("assets/doge.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Column(
                        children: [
                          Text("Doge DAO", style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Text(" Doge DAO is a \n community driven\n DAO \n . . . .", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(onPressed: (){}, child: Text("Enter", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height*0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F0E0),
                ),
                height: height*0.2,
                width: width*0.9,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                      ),
                      width: width*0.3,
                      padding: const EdgeInsets.all(10),
                      height: height*0.2,
                      child: Image.asset("assets/doge.jpg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Column(
                        children: [
                          Text("Doge DAO", style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Text(" Doge DAO is a \n community driven\n DAO \n . . . .", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(onPressed: (){}, child: Text("Enter", style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}


  