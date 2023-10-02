import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  late String name;
  late String price;
  late String description;

  ServiceModel(
      {required this.name, required this.price, required this.description});

  toJason() {
    return {'Name': name, 'Price': price, 'Description': description};
  }

  factory ServiceModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapShot) {
    final data = documentSnapShot.data()!;
    return ServiceModel(
        name: data['Name'],
        price: data['Price'],
        description: data['Description']);
  }
}
