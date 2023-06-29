import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

import 'package:temp/screens/bounty_page.dart';

class DataPage extends StatefulWidget {
  final String daoName;

  // ignore: use_key_in_widget_constructors
  const DataPage({required this.daoName});

  @override
  // ignore: library_private_types_in_public_api
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<DaoData> _daoData;
    @override
  void initState() {
    super.initState();
    _daoData = _fetchDaoData();
  }

  Future<DaoData> _fetchDaoData() async {
    final response = await http.get(Uri.parse('http://192.168.29.117:8080/getSingleDAO?dao=${widget.daoName}'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedData = json.decode(responseBody);
      final daoData = DaoData.fromJson(decodedData['data']);
      return daoData;
    } else {
      throw Exception('Failed to load DAO data');
    }
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
        title: const Text("D A O   D A T A", style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),),
        centerTitle: true,
      ),
      body: FutureBuilder<DaoData>(
        future: _daoData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final daoData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    daoData.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    daoData.id,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Members:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    daoData.members.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  Container(
              height: 40,
              width: 120,
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
                 onPressed: (){ Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BountyPage(daoName: daoData.name),
                                          ),
                                        );},
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
                      "Bounties",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DaoData {
  final String description;
  final String id;
  final List<Member> members;
  final String name;

  DaoData({
    required this.description,
    required this.id,
    required this.members,
    required this.name,
  });

  factory DaoData.fromJson(Map<String, dynamic> json) {
    final members = List<Member>.from(json['members'].map((member) => Member.fromJson(member)));
    return DaoData(
      description: json['description'],
      id: json['id'],
      members: members,
      name: json['name'],
    );
  }
}

class Member {
  final String collectionId;
  final String id;

  Member({
    required this.collectionId,
    required this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final modifiedId = id.replaceFirst('TestDAO', '');

    return Member(
      collectionId: json['collectionId'],
      id: modifiedId,
    );
  }

  @override
   String toString() {
    return '$id\n';
  }
}

