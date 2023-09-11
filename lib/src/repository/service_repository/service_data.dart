import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController {
  static FirebaseService get instance => Get.find();
  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Categories')
        .limit(4)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getSkinCareSubcollection(
      String subCategories, String id) async {
    final QuerySnapshot skinCareQuery = await FirebaseFirestore.instance
        .collection('Categories') // Replace with your collection name
        .doc(id) // Replace with the specific document ID
        .collection(subCategories) // Subcollection name
        .get();

    return skinCareQuery.docs
        .map((docs) => docs.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchAllCategoties() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchRandomCategory() async {
    // Fetch all collection names from Firestore
    QuerySnapshot collectionsSnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    // Extract the collection names from the snapshot
    List<String> collectionNames =
        collectionsSnapshot.docs.map((doc) => doc.id).toList();

    // Shuffle the collection names randomly
    collectionNames.shuffle(Random());

    // Select the first (random) collection name
    String randomCollectionName = collectionNames.first;

    // Fetch the documents from the selected collection
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(randomCollectionName).get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchCategoties(String categoties) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(categoties).get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchAllCategotieTest() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getServicesByCategory() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Services')
        .where('Category', isEqualTo: 'category_id_1')
        .get();

    return snapshot.docs
        .map((docs) => docs.data() as Map<String, dynamic>)
        .toList();
  }
}
