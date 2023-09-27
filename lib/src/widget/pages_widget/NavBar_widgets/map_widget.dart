import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../getx/map_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = Get.put(MapController());
  late GoogleMapController googleMapController;
  late LatLng initialPosition = const LatLng(26.077444, 50.542476);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mapController.getMarker(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            final markers = snapShot.data;
            return Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                markers: markers!,
                myLocationEnabled: true,
                onTap: (position) =>
                    mapController.customInfoWindowController.hideInfoWindow!(),
                onCameraMove: (position) {
                  mapController.customInfoWindowController.onCameraMove!();
                },
                initialCameraPosition: CameraPosition(
                    bearing: 192.8334901395799,
                    target: initialPosition,
                    tilt: 59.440717697143555,
                    zoom: 10.5),
                onMapCreated: (GoogleMapController controller) {
                  mapController.customInfoWindowController.googleMapController =
                      controller;
                },
                myLocationButtonEnabled: true,
              ),
              CustomInfoWindow(
                controller: mapController.customInfoWindowController,
                width: 200.w,
                height: 300.h,
                offset: 35,
              ),
            ]);
          } else if (snapShot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else if (initialPosition == const LatLng(0, 0)) {
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
