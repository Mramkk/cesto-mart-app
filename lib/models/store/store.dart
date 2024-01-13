// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  int id;
  int userId;
  String name;
  String email;
  String mobile;
  String whatsapp;
  String aadhar;
  String pan;
  String gstin;
  String state;
  String city;
  String division;
  String area;
  String pincode;
  String address;
  String document;
  String longitude;
  String latitude;
  DateTime createdAt;
  DateTime updatedAt;

  StoreModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.whatsapp,
    required this.aadhar,
    required this.pan,
    required this.gstin,
    required this.state,
    required this.city,
    required this.division,
    required this.area,
    required this.pincode,
    required this.address,
    required this.document,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        whatsapp: json["whatsapp"],
        aadhar: json["aadhar"],
        pan: json["pan"],
        gstin: json["gstin"],
        state: json["state"],
        city: json["city"],
        division: json["division"],
        area: json["area"],
        pincode: json["pincode"],
        address: json["address"],
        document: json["document"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "mobile": mobile,
        "whatsapp": whatsapp,
        "aadhar": aadhar,
        "pan": pan,
        "gstin": gstin,
        "state": state,
        "city": city,
        "division": division,
        "area": area,
        "pincode": pincode,
        "address": address,
        "document": document,
        "longitude": longitude,
        "latitude": latitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
