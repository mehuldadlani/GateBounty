// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class DAOData {
  final String description;
  final String id;
  final List<dynamic> members;
  final String name;

  DAOData({
    required this.description,
    required this.id,
    required this.members,
    required this.name,
  });

  DAOData copyWith({
    String? description,
    String? id,
    List<dynamic>? members,
    String? name,
  }) {
    return DAOData(
      description: description ?? this.description,
      id: id ?? this.id,
      members: members ?? this.members,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'id': id,
      'members': members,
      'name': name,
    };
  }

  factory DAOData.fromMap(Map<String, dynamic> map) {
  final dataMap = map['data'] as Map<String, dynamic>?; 
  if (dataMap != null) {
    return DAOData(
      description: dataMap['description'] as String? ?? '',
      id: dataMap['id'] as String? ?? '',
      members: List<dynamic>.from(dataMap['members'] as List<dynamic>? ?? []),
      name: dataMap['name'] as String? ?? '',
    );
  } else {
    throw Exception('Invalid response format: data field is missing');
  }
}

static List<DAOData> parseDAODataList(String responseBody) {
  final parsed = json.decode(responseBody);
  final dataList = parsed['data'] as List<dynamic>?; 

  if (dataList != null) {
    return dataList.map((item) {
      final daoData = DAOData.fromMap(item);
      return daoData;
    }).toList();
  } else {
    throw Exception('Invalid response format: data field is missing');
  }
}

  @override
  String toString() {
    return 'DAOData(description: $description, id: $id, members: $members, name: $name)';
  }

  @override
  bool operator ==(covariant DAOData other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.id == id &&
        listEquals(other.members, members) &&
        other.name == name;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        id.hashCode ^
        members.hashCode ^
        name.hashCode;
  }

  static fromJson(decodedData) {}
}
