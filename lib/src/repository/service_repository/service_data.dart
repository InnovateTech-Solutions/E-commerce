import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService {
  static FirebaseService get instance => Get.find();

  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
