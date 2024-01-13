// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String empCode;
  String name;
  String email;
  String mobile;
  String emailVerifiedAt;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.empCode,
    required this.name,
    required this.email,
    required this.mobile,
    required this.emailVerifiedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        empCode: json["emp_code"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        mobile: json["mobile"].toString(),
        emailVerifiedAt: json["email_verified_at"].toString(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_code": empCode,
        "name": name,
        "email": email,
        "mobile": mobile,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
