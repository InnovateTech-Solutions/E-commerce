import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/vendor_model.dart';

class SearchControllerr extends GetxController {
  final String category;
  SearchControllerr(this.category);

  final _db = FirebaseFirestore.instance;

  RxList<VendorModel> mainList = RxList<VendorModel>([]);
  RxList<VendorModel> filteredList = <VendorModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVendorByCategory(category);
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<VendorModel>> fetchVendorByCategory(String category) async {
    try {
      // #1 fetching the vendors data, #2 initializing the mainList and the filtered list
      final querySnapshot = await _db
          .collection('Vendors')
          .where('Category', isEqualTo: category)
          .get();
      mainList.assignAll(
        querySnapshot.docs.map((doc) => VendorModel.fromSnapshot(doc)).toList(),
      );
      filteredList.assignAll(mainList);
    } catch (e) {
      // Handle any errors that may occur during the Firestore fetch.
      print("Error fetching players: $e");
    }
    return filteredList;
  }

  void filterPlayer(String playerName) {
    List<VendorModel> result = RxList<VendorModel>([]);

    if (playerName.isEmpty) {
      // If the search query is empty, simply assign the original list to foundPlayers.
      filteredList.assignAll(mainList);
    } else {
      result = mainList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
      filteredList.assignAll(result);
    }
  }
}
