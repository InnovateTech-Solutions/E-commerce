import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  final RxList<Map<String, dynamic>> myDataList = <Map<String, dynamic>>[].obs;

  // Fetch data from Firebase Firestore and update myDataList
  Future<void> fetchDataAndUpdate() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Categories').get();

      List<Map<String, dynamic>> newData = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
          .toList();

      myDataList.assignAll(newData);
    } catch (e) {
      // Handle errors
    }
  }

  Future<List<Map<String, dynamic>>> fetchFromFirebaseStorage() async {
    // Simulate fetching data from Firebase Storage
    await Future.delayed(const Duration(seconds: 2));

    return [
      {'title': 'Item 1', 'description': 'Description 1'},
      {'title': 'Item 2', 'description': 'Description 2'},
      // Add your Firebase data fetching logic here
    ];
  }
}
