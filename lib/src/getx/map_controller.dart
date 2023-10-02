import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_part/src/widget/partial_widget/map_partial/map_partial.dart';

class MapController extends GetxController {
  static MapController get instance => Get.find();

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  static LatLng? initialPosition;

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> markers = [];

  Future<Set<Marker>> getMarker() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('Vendors');
    final querySnapshot = await collectionReference.get();

    for (var doc in querySnapshot.docs) {
      String title = doc['Name'];
      final coordinate = doc['Coordinates'];
      final image = doc['Image'];
      final latLng = coordinate.split(',');
      final latitude = double.tryParse(latLng[0].trim()) ?? 0.0;
      final longitude = double.tryParse(latLng[1].trim()) ?? 0.0;

      markers.add(
        Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          onTap: () => {
            customInfoWindowController.addInfoWindow!(
                mapDialog(
                  image: image,
                  title: title,
                ),
                LatLng(latitude, longitude))
          },
        ),
      );
    }
    return markers.toSet();
  }

  Future<Position> determinePosition() async {
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

    return position;
  }
}
