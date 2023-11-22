import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  DashboardController get instance => Get.find();
  RxString selectedItem = "Jordan".obs;
  List location = ["Jordan", "Bahrian"];

  void upDateSelectedItem(String value) {
    selectedItem.value = value;
  }

  Future<List<Map<String, dynamic>>> getNailVendors() async {
    List<Map<String, dynamic>> vendors = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('Category', isEqualTo: 'Nail Salon')
        .get();

    querySnapshot.docs.forEach((doc) {
      vendors.add(doc.data() as Map<String, dynamic>);
    });
    return vendors;
  }

  Future<List<Map<String, dynamic>>> getTopRated() async {
    List<Map<String, dynamic>> vendors = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('averageRating', isGreaterThan: 4)
        .get();

    querySnapshot.docs.forEach((doc) {
      vendors.add(doc.data() as Map<String, dynamic>);
    });
    return vendors;
  }
}
