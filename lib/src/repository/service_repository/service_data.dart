import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/categories_model.dart';
import 'package:profile_part/src/model/product_model.dart';

class FirebaseService extends GetxController {
  static FirebaseService get instance => Get.find();
  final _db = FirebaseFirestore.instance;
   RxList<Product> products = <Product>[].obs;

     @override
  void onInit() {
    super.onInit();
    
  }

  @override
  void onReady() {
    super.onReady();
  }

    void filterPlayer(String playerName) {
    RxList<Product> results = <Product>[].obs;
    if (playerName.isEmpty) {
      results = products;
    } else {
      results = products
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList().obs;
    }
    products.value = results;
  }


  Future<Map<String, List<DocumentSnapshot>>> fetchAdsAndCategories() async {
    ////that query fetch all categories , that used in Categories widget
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

  Future<List<Categories>> fetchAllCategories() async {
//that query fetch all categories , that used in Categories widget
    final querySnapshot = await _db.collection('Categories').get();

    return querySnapshot.docs
        .map((doc) => Categories.fromSnapshot(doc))
        .toList();
  }

  Future<List<Product>> fetchVendorByCategory(String category) async {
    //that query fetch all vendors in each Category , that used in products widget

    final querySnapshot = await _db
        .collection('Vendors')
        .where('Category', isEqualTo: category)
        .get();
        products = querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList().obs;       
    return querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
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
}
