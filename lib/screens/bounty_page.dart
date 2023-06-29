import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BountyPage extends StatefulWidget {
  final String daoName;

  BountyPage({required this.daoName});

  @override
  _BountyPageState createState() => _BountyPageState();
}

class _BountyPageState extends State<BountyPage> {
  late Future<List<Bounty>> _bountyList;

  @override
  void initState() {
    super.initState();
    _bountyList = _fetchBountyList();
  }

  Future<List<Bounty>> _fetchBountyList() async {
    final response = await http.get(Uri.parse('http://192.168.29.117:8080/getBounty?dao=${widget.daoName}'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedData = json.decode(responseBody) as List<dynamic>;
      final bountyList = decodedData.map((json) => Bounty.fromJson(json)).toList();
      return bountyList;
    } else {
      throw Exception('Failed to load bounties');
    }
  }

  void handleButtonPress() {
    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Bounty submitted successfully!'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDE9FE),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xffEDE9FE),
        title: Text(
          widget.daoName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20), 
        ),
      ),
      body: FutureBuilder<List<Bounty>>(
        future: _bountyList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bountyList = snapshot.data!;
            return ListView.builder(
              itemCount: bountyList.length,
              itemBuilder: (context, index) {
                final bounty = bountyList[index];
                return ListTile(
                  title: Text(
                    bounty.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), 
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8), 
                      Text(
                        bounty.details,
                        style: TextStyle(fontSize: 18), 
                      ),
                      SizedBox(height: 4), 
                      Text(
                        'Deadline: ${DateTime.fromMillisecondsSinceEpoch(bounty.deadline)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                      ),
                      SizedBox(height: 20),
                      Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                border: Border.all(color: Color(0xff8B5CF6), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () => handleButtonPress(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: 
                    Text(
                      "Submit Bounty",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 20),
                    ],
                  ),
                  trailing: Text(
                    bounty.prize,
                    style: TextStyle(fontSize: 18), 
                  ),
                  
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: TextStyle(fontSize: 16), 
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



class Bounty {
  final String title;
  final String details;
  final String prize;
  final int deadline;

  Bounty({
    required this.title,
    required this.details,
    required this.prize,
    required this.deadline,
  });

  factory Bounty.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return Bounty(
      title: data['title'],
      details: data['details'],
      prize: data['prize'],
      deadline: data['deadline'],
    );
  }
}
