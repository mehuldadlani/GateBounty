import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:temp/auth_demo/auth_logic.dart';
import 'package:temp/model/dao_model.dart' as Model;
import 'package:temp/screens/data_page.dart';
import 'package:temp/widgets/my_drawer.dart';

class DAOPage extends StatefulWidget {
  const DAOPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DAOPageState createState() => _DAOPageState();
}

class _DAOPageState extends State<DAOPage> {
  late Future<List<Model.DAOData>> _daoList;

  Future<List<Model.DAOData>> _fetchDAOList() async {
    final response = await http.get(Uri.parse('http://192.168.29.117:8080/getDAO'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      // ignore: unnecessary_null_comparison
      if (responseBody != null) {
        return Model.DAOData.parseDAODataList(responseBody);
      } else {
        throw Exception('Response body is null');
      }
    } else {
      throw Exception('Failed to load DAOs');
    }
  }

  Future<bool> checkNFT(String daoId) async {
    bool isNftThere = false;
    var url = Uri.parse('http://192.168.29.117:8080/checkNFT');

    Map<String, String> requestBody = {
      "publicKey": AuthLogic.evmPubAddress ?? '',
      "dao": daoId,
    };

    final response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final responseBody = response.body;
      // ignore: unnecessary_null_comparison
      if (responseBody != null) {
        Map<String, dynamic> jsonData = json.decode(responseBody);
        if (jsonData['data'] == null && jsonData['block'] == null) {
          isNftThere = false;
        } else {
          isNftThere = true;
        }
      } else {
        throw Exception('Response body is null');
      }
    } else {
      throw Exception('Failed to load');
    }

    return isNftThere;
  }

  @override
  void initState() {
    super.initState();
    _daoList = _fetchDAOList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: const Color(0xffE7E0D3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE7E0D3),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "D  A  O",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: FutureBuilder<List<Model.DAOData>>(
        future: _daoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final daoList = snapshot.data!;
            return ListView.builder(
              itemCount: daoList.length,
              itemBuilder: (context, index) {
                final daoData = daoList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(top: 15, left: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF4F0E0),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          width: width * 0.3,
                          padding: const EdgeInsets.all(10),
                          height: height * 0.2,
                          child: Image.asset("assets/doge.png"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                daoData.id,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                daoData.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffE7E0D3),
                                  onPrimary: Colors.black,
                                  elevation: 0,
                                  minimumSize: const Size(100, 40),
                                ),
                                onPressed: () async {
                                  bool isNftThere = await checkNFT(daoData.id);
                                  if (isNftThere) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DataPage(daoName: daoData.id),
                                      ),
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('NFT not available'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('View Data'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
