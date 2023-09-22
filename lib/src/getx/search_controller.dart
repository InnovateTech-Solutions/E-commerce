import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_part/src/model/product_model.dart';

class SearchControllerr extends GetxController {
  final String category;
  SearchControllerr(this.category);
  
  final _db = FirebaseFirestore.instance;

   RxList<Product> mainList = RxList<Product>([]);
   RxList<Product> filteredList = <Product>[].obs;

     @override
  void onInit() {
    super.onInit();
    fetchVendorByCategory(category);
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<Product>> fetchVendorByCategory(String category) async {
    try { // #1 fetching the vendors data, #2 initializing the mainList and the filtered list
      final querySnapshot = await _db
          .collection('Vendors')
          .where('Category', isEqualTo: category)
          .get();
      mainList.assignAll(
        querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList(),
      );
      filteredList.assignAll(mainList);
    } catch (e) {
      // Handle any errors that may occur during the Firestore fetch.
      print("Error fetching players: $e");
    }
     return filteredList;

  }




void filterPlayer(String playerName) {
  List<Product> result = RxList<Product>([]);

  if (playerName.isEmpty) {
    // If the search query is empty, simply assign the original list to foundPlayers.
    filteredList.assignAll(mainList);
  } else {
     result = mainList.
        where((element) => element.name
            .toString()
            .toLowerCase()
            .contains(playerName.toLowerCase()))
        .toList();
    filteredList.assignAll(result);
  }
}
}
