import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? serviceId;
  late String title;
  late String imgName;

  ServiceModel({this.serviceId, required this.title, required this.imgName});

  factory ServiceModel.fromsanshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapShot) {
    final data = documentSnapShot.data()!;
    return ServiceModel(
        serviceId: data['id'], title: data['Title'], imgName: data['image']);
  }
}
