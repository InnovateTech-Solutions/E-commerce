import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String category;
  late String description;
  late String image;
  late String name;
  Product(
      {required this.category,
      required this.description,
      required this.image,
      required this.name});

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return Product(
        category: data['Category'],
        description: data['Description'],
        image: data['Image'],
        name: data['Name']);
  }
}
