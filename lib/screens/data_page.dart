import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:temp/screens/bounty_page.dart';

class DataPage extends StatefulWidget {
  final String daoName;

  DataPage({required this.daoName});

  @override
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
    final response = await http.get(Uri.parse('http://192.168.29.117:8000/getSingleDAO?dao=${widget.daoName}'));

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
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffE7E0D3),
        title: Text("D A O   D A T A", style: TextStyle(
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
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    daoData.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    daoData.id,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Members:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    daoData.members.toString(),
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 255, 255),
                                  onPrimary: Colors.black,
                                  elevation: 0,
                                  minimumSize: const Size(100, 40),
                                ),
                    onPressed: (){ Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BountyPage(daoName: daoData.name),
                                          ),
                                        );}, child: Text("Bounties")),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return Center(child: CircularProgressIndicator());
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
    return id;
  }
}
