import 'package:flutter/material.dart';
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
    final response = await http.get(Uri.parse('http://192.168.29.117:8000/getBounty?dao=${widget.daoName}'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedData = json.decode(responseBody) as List<dynamic>;
      final bountyList = decodedData.map((json) => Bounty.fromJson(json)).toList();
      return bountyList;
    } else {
      throw Exception('Failed to load bounties');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffE7E0D3),
        title: Text(
          widget.daoName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20), // Increase the font size
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
                    style: TextStyle(fontSize: 18), // Increase the font size
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8), // Add spacing between texts
                      Text(
                        bounty.details,
                        style: TextStyle(fontSize: 16), // Increase the font size
                      ),
                      SizedBox(height: 4), // Add spacing between texts
                      Text(
                        'Deadline: ${DateTime.fromMillisecondsSinceEpoch(bounty.deadline)}',
                        style: TextStyle(fontSize: 14), // Increase the font size
                      ),
                    ],
                  ),
                  trailing: Text(
                    bounty.prize,
                    style: TextStyle(fontSize: 18), // Increase the font size
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: TextStyle(fontSize: 16), // Increase the font size
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