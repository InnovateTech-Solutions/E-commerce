import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/vendor_model.dart';

class VendorController extends GetxController {
  late String vendorCategory;
  RxList<VendorModel> vendors = <VendorModel>[].obs;
  VendorController(this.vendorCategory);
  @override
  void onInit() {
    super.onInit();
    fetchVendorsByCategory(vendorCategory);
  }

  Future<void> fetchVendorsByCategory(String vendorCategory) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('Category', isEqualTo: vendorCategory)
        .get();

    // Get the documents and shuffle them
    List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    documents.shuffle();

    // Map shuffled documents to VendorModel objects and update the list
    vendors.assignAll(
        documents.map((doc) => VendorModel.fromSnapshot(doc)).take(5).toList());
  }
}
