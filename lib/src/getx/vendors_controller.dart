import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/vendor_model.dart';

class VendorController extends GetxController {
  late String vendorCategory;
  RxList<VendorModel> vendors = <VendorModel>[].obs;
  RxString imageName = ''.obs;
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

  Future<void> getImageName(String vendorName) async {
    try {
      // Get reference to the Firestore collection
      CollectionReference vendors =
          FirebaseFirestore.instance.collection('Vendors');

      // Query the collection based on vendor name
      QuerySnapshot querySnapshot =
          await vendors.where('Name', isEqualTo: vendorName).get();

      // Check if there is a matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the imgname field from the first document
        String imgName = querySnapshot.docs.first.get('Image');
        imageName.value = imgName;
      } else {
        // No matching document found
        imageName.value = '';
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error getting image name: $e');
      imageName.value = '';
    }
  }
}
