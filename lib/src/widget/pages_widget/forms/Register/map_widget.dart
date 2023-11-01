import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../getx/map_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

const kGoogleApiKey = 'AIzaSyCN6q7C0ellujImVkI4Z2yVyOysn5Mnv8g';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MapWidgetState extends State<MapWidget> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);
  final MapController mapController = Get.put(MapController());
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: homeScaffoldKey,
      children: [
        Obx(
          () => GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: mapController.markersList.toSet(),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              mapController.googleMapController = controller;
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: ElevatedButton(
              onPressed: () => Get.back(), child: const Text("Add Coordinate")),
        ),
        Positioned(
          top: 10,
          child: ElevatedButton(
              onPressed: handlePressButton, child: const Text("Search Places")),
        )
      ],
    );
  }

  Future<void> handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "uk")
        ]);

    mapController.displayPrediction(p!, homeScaffoldKey.currentState);
  }
}
