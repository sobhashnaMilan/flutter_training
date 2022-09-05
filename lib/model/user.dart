// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

List<User> userFromMap(String str) => List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

String userToMap(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  int id;
  String name;
  String email;
  String gender;
  String status;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "status": status,
  };
}