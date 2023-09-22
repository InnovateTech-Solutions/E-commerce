import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/product_model.dart';

class HomeController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxList<Product> foundPlayers = RxList<Product>([]);
  RxList<Product> mainList = RxList<Product>([]);

  @override
  void onInit() {
    super.onInit();
    // Initialize the foundPlayers list with data from Firestore when the controller is initialized.
    fetchVendorByCategory("Skin care");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> fetchVendorByCategory(String category) async {
    try {
      final querySnapshot = await _db
          .collection('Vendors')
          .where('Category', isEqualTo: category)
          .get();
      mainList.assignAll(
        querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList(),
      );
      foundPlayers.assignAll(mainList);
    } catch (e) {
      // Handle any errors that may occur during the Firestore fetch.
      print("Error fetching players: $e");
    }
  }

void filterPlayer(String playerName) {
  List<Product> result = RxList<Product>([]);

  if (playerName.isEmpty) {
    // If the search query is empty, simply assign the original list to foundPlayers.
    foundPlayers.assignAll(mainList);
  } else {
     result = mainList.
        where((element) => element.name
            .toString()
            .toLowerCase()
            .contains(playerName.toLowerCase()))
        .toList();
    foundPlayers.assignAll(result);
  }
}



}
