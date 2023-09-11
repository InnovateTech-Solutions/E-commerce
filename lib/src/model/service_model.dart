import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  late String serviceId;
  late String title;
  late String imgName;

  ServiceModel(
      {required this.serviceId, required this.title, required this.imgName});

  factory ServiceModel.fromsanshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapShot) {
    final data = documentSnapShot.data()!;
    return ServiceModel(
        serviceId: data['id'], title: data['Title'], imgName: data['image']);
  }
}
