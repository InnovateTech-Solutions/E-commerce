import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VendorImage extends GetxController {
  static VendorImage get instance => Get.find();
  RxString imageName = ''.obs;

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
