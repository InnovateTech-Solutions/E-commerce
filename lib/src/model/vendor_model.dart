import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  late String name;
  late String description;
  late String image;
  String? address;
  String? coordinates;
  double? averageRating;
  String? category;

  VendorModel(
      {required this.name,
      required this.description,
      required this.image,
      this.address,
      this.coordinates,
      this.averageRating,
      this.category});

  factory VendorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;

    return VendorModel(
        name: data['Name'],
        description: data['Description'],
        image: data['Image'],
        address: data['Address'],
        coordinates: data['Coordinates'],
        averageRating: data['averageRating'],
        category: data['Category']);
  }
}
