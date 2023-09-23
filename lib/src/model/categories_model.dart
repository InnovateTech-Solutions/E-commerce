import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  late String image;
  late String title;
  Categories({required this.title, required this.image});

  factory Categories.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return Categories(title: data['Title'], image: data['image']);
  }
}
