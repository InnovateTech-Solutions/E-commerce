import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  late String name;
  late String password;
  late String email;
  late String phone;
  late String? imageUrl;
  late String? age;
  late String? gander;

  UserModel(
      {this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.imageUrl,
      required this.age,
      required this.gander});

  tojason() {
    return {
      "Email": email,
      "Password": password,
      "PhoneNumber": phone,
      "UserName": name,
      "Age": age,
      "Gander": gander,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
      id: documentSnapshot.id,
      email: data["Email"],
      name: data["UserName"],
      password: data["Password"],
      phone: data["PhoneNumber"],
      imageUrl: data["imageUrl"],
      age: data["Age"],
      gander: data["Gander"],
    );
  }
}
