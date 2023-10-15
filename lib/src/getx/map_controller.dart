import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  RxList<Marker> markers = <Marker>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString selectedVendorId = ''.obs;
  RxMap selectedVendorData = {}.obs;

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  @override
  void onInit() {
    super.onInit();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final newMarkers = await getMarkers();
    markers.assignAll(newMarkers);
  }

  Future<Set<Marker>> getMarkers() async {
    final collectionReference = firestore.collection('Vendors');
    final querySnapshot = await collectionReference.get();
    final newMarkers = <Marker>{};

    for (var doc in querySnapshot.docs) {
      final coordinate = doc['Coordinates'];
      final latLng = coordinate.split(',');
      final latitude = double.tryParse(latLng[0].trim()) ?? 0.0;
      final longitude = double.tryParse(latLng[1].trim()) ?? 0.0;

      newMarkers.add(
        Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          onTap: () => _onMarkerTapped(doc.id),
        ),
      );
    }

    return newMarkers;
  }

  Future<void> _onMarkerTapped(String vendorId) async {
    final vendorDoc = await firestore.collection('Vendors').doc(vendorId).get();
    if (vendorDoc.exists) {
      selectedVendorId.value = vendorId;
      selectedVendorData.value = vendorDoc.data() as Map<String, dynamic>;
    }
  }
}
