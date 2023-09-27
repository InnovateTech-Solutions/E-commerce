import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories {
  late String image;
  late String title;
  late VoidCallback? callback;
  Categories({required this.title, required this.image, this.callback});

  factory Categories.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return Categories(title: data['Title'], image: data['image']);
  }
}
