// To parse this JSON data, do
//
//     final updateprofileresponsemodel = updateprofileresponsemodelFromMap(jsonString);

import 'dart:convert';

Updateprofileresponsemodel updateprofileresponsemodelFromMap(String str) => Updateprofileresponsemodel.fromMap(json.decode(str));

String updateprofileresponsemodelToMap(Updateprofileresponsemodel data) => json.encode(data.toMap());

class Updateprofileresponsemodel {
    final int id;
    final String name;
    final String email;
    final dynamic image;
    final dynamic emailVerifiedAt;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String role;
    final dynamic phone;
    final dynamic address;
    final int isActive;

    Updateprofileresponsemodel({
        required this.id,
        required this.name,
        required this.email,
        required this.image,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.role,
        required this.phone,
        required this.address,
        required this.isActive,
    });

    factory Updateprofileresponsemodel.fromMap(Map<String, dynamic> json) => Updateprofileresponsemodel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: json["role"],
        phone: json["phone"],
        address: json["address"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": role,
        "phone": phone,
        "address": address,
        "is_active": isActive,
    };
}
