import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  static MapController get instance => Get.find();

  final Completer<GoogleMapController> Controller =
      Completer<GoogleMapController>();
  static LatLng? initialPosition;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(20.42796133580664, 75.885749655962),
    zoom: 14.4746,
  );

  // CameraPosition kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: determinePosition(),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  Future<Set<Marker>> getMarker() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('markers');
    final querySnapshot = await collectionReference.get();
    List<Marker> markers = [];

    for (var doc in querySnapshot.docs) {
      String title = doc['place'];
      final address = doc['address'];
      final latLng = address.split(',');
      final latitude = double.tryParse(latLng[0].trim()) ?? 0.0;
      final longitude = double.tryParse(latLng[1].trim()) ?? 0.0;

      markers.add(
        Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: title),
        ),
      );
    }
    return markers.toSet();
  }

  Future<LatLng> determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      return Future.error('Location services are disable');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    initialPosition = LatLng(position.latitude, position.longitude);
    print(initialPosition);
    return initialPosition!;
  }
}
