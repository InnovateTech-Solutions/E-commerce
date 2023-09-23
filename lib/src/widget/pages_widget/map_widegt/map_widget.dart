import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../getx/map_controller.dart';

class MapWidget extends StatefulWidget {
  MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = Get.put(MapController());

  late LatLng initialPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    _setInitialPosition();
  }

  Future<void> _setInitialPosition() async {
    final LatLng position = await mapController.determinePosition();
    setState(() {
      initialPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mapController.getMarker(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            final markers = snapShot.data;
            return GoogleMap(
              mapType: MapType.normal,
              markers: markers!,
              initialCameraPosition: CameraPosition(
                  bearing: 192.8334901395799,
                  target: initialPosition,
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414),
              onMapCreated: (GoogleMapController controller) {
                mapController.Controller.complete(controller);
              },
              myLocationButtonEnabled: true,
            );
          } else if (snapShot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else if (initialPosition == LatLng(0, 0)) {
            return const Center(child: CircularProgressIndicator());
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
