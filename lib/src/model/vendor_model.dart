import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  late String name;
  late String description;
  late String image;
  String? address;
  String? coordinates;

  VendorModel({
    required this.name,
    required this.description,
    required this.image,
    this.address,
    this.coordinates,
  });

  factory VendorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;

    return VendorModel(
      name: data['Name'],
      description: data['Description'],
      image: data['Image'],
      address: data['Address'],
      coordinates: data['Coordinates'],
    );
  }
}
