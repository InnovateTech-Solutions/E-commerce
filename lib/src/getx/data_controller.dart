import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/categories_model.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();
  Future<Future<Map<String, List<DocumentSnapshot<Object?>>>>>
      fetchAdsAndCategories() async {
    // fetch All categorie And Ads
    return FirebaseService.instance.fetchAdsAndCategories();
  }

  Future<List<Categories>> fetchAllCategories() {
    // fetch All categorie : Title , image , id
    return FirebaseService.instance.fetchAllCategories();
  }

  Future<List<VendorModel>> fetchVendorByCategory(String category) {
    //fetch Service (all vendors) by Passing The category Name
    return FirebaseService.instance.fetchVendorByCategory(category);
  }

  Future<List<ServiceModel>> fetchServicebyVendorName(String vendorName) {
    //fetch services for vendors
    return FirebaseService.instance.fetchServicebyName(vendorName);
  }

  Future<List<VendorModel>> fetchCategoriesByVendor(String categorie) {
    // fetch categoires that smeller to vendor categorie
    return FirebaseService.instance.fetchCategoriesByVendor(categorie);
  }
}
