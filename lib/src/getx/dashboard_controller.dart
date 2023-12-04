import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  DashboardController get instance => Get.find();
  RxString selectedItem = "Jordan".obs;
  List location = ["Jordan", "Bahrian"];
  RxString llocation = 'Fetching location...'.obs;

  void upDateSelectedItem(String value) {
    selectedItem.value = value;
  }

  Future<List<Map<String, dynamic>>> getNailVendors() async {
    List<Map<String, dynamic>> vendors = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('Category', isEqualTo: 'Nail Salon')
        .get();

    querySnapshot.docs.forEach((doc) {
      vendors.add(doc.data() as Map<String, dynamic>);
    });
    return vendors;
  }

  Future<List<Map<String, dynamic>>> getTopRated() async {
    List<Map<String, dynamic>> vendors = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('averageRating', isGreaterThan: 4)
        .get();

    querySnapshot.docs.forEach((doc) {
      vendors.add(doc.data() as Map<String, dynamic>);
    });
    return vendors;
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  List<String> categoryNames = [
    "dental clinic",
    "Therapy",
    "Spa",
    "Skin care",
    "Nail Salon",
    "Hair Services"
  ];

  int shuffleIndex(List<String> strings) {
    if (strings.isEmpty) {
      throw ArgumentError('The list of strings must not be empty');
    }

    // Generate a random index within the range of the list length
    Random random = Random();
    int randomIndex = random.nextInt(strings.length);

    return randomIndex;
  }

  Future<List<Map<String, dynamic>>> getRandomVendors(String category) async {
    List<Map<String, dynamic>> vendors = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Vendors')
        .where('Category', isEqualTo: category)
        .get();

    querySnapshot.docs.forEach((doc) {
      vendors.add(doc.data() as Map<String, dynamic>);
    });
    return vendors;
  }
}

class GeolocatorService extends GetxController {
  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }
}
