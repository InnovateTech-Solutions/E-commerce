import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/categories_model.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';

class FirebaseService extends GetxController {
  static FirebaseService get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  RxList timeList = [].obs;

  Future<Map<String, List<DocumentSnapshot>>> fetchAdsAndCategories() async {
    ////that query fetch all categories , that used in Dashboard widget
    final adsQuery = _db.collection('Ads').get();
    final categoriesQuery = _db.collection('Categories').limit(4).get();

    final results = await Future.wait([adsQuery, categoriesQuery]);

    List<DocumentSnapshot> ads = results[0].docs;
    List<DocumentSnapshot> categories = results[1].docs;

    return {
      'ads': ads,
      'categories': categories,
    };
  }

  void generateTimeList(String timeRange) {
    final parts = timeRange.split(' - ');

    if (parts.length != 2) {
      print("error: start and end time should be specified");
    }

    final startTime = parts[0];
    final endTime = parts[1];

    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1]);
    final endHour = int.parse(endTime.split(':')[0]);
    final endMinute = int.parse(endTime.split(':')[1]);

    DateTime currentTime = DateTime(2023, 1, 1, startHour, startMinute);

    while (currentTime.hour < endHour ||
        (currentTime.hour == endHour && currentTime.minute <= endMinute)) {
      timeList.add(
          '${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}');
      currentTime =
          currentTime.add(Duration(minutes: 30)); // Increment by 30 minutes
    }
  }

  Future<List<Categories>> fetchAllCategories() async {
//that query fetch all categories , that used in Categories widget
    final querySnapshot = await _db.collection('Categories').get();

    return querySnapshot.docs
        .map((doc) => Categories.fromSnapshot(doc))
        .toList();
  }

  Future<List<VendorModel>> fetchVendorByCategory(String category) async {
    final querySnapshot = await _db
        .collection('Vendors')
        .where('Category', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => VendorModel.fromSnapshot(doc))
        .toList();
  }

  Future<List<ServiceModel>> fetchServicebyName(String name) async {
    final querySnapshot = await _db
        .collection('Services')
        .where('Vendor_Id', isEqualTo: name)
        .get();

    return querySnapshot.docs
        .map((docs) => ServiceModel.fromSnapshot(docs))
        .toList();
  }

// not used querys

  Future<List<Map<String, dynamic>>> getSkinCareSubcollection(
      String subCategories, String id) async {
    //sub collection call examle
    final QuerySnapshot skinCareQuery = await FirebaseFirestore.instance
        .collection('Categories') // Replace with your collection name
        .doc(id) // Replace with the specific document ID
        .collection(subCategories) // Subcollection name
        .get();

    return skinCareQuery.docs
        .map((docs) => docs.data() as Map<String, dynamic>)
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

  Future<List<Map<String, dynamic>>> getAllCategory() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAllAds() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Ads').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> fetchCategoriesByVedor(
      String vendorName) async {
    final querySnapshot = await _db
        .collection('Vendors')
        .where('Vendor_Id', isEqualTo: vendorName)
        .get();

    return querySnapshot.docs
        .map((docs) => docs.data() as Map<String, dynamic>)
        .toList();
  }
}
