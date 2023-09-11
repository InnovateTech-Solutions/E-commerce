import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../getx/map_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mapController.getMarker(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            final markers = snapShot.data;
            return Scaffold(
              body: GoogleMap(
                mapType: MapType.normal,
                markers: markers!,
                initialCameraPosition: mapController.kLake,
                onMapCreated: (GoogleMapController controller) {
                  mapController.Controller.complete(controller);
                },
              ),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text(snapShot.error.toString()));
          } else {
            return const Text("somthing went wrong");
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
