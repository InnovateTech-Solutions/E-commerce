import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  late MarkerId? id;
  late String name;
  late String image;
  String? coordinates;

  MapModel({
    this.id,
    required this.name,
    required this.image,
    this.coordinates,
  });
  factory MapModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return MapModel(
      id: MarkerId('id'),
      name: data['Name'],
      image: data['Image'],
      coordinates: data['Coordinates'],
    );
  }
}
