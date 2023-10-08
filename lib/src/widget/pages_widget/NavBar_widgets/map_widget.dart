import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/map_controller.dart';
import 'package:profile_part/src/widget/Text_Widget/map_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/transition/map_transition.dart';

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
      future: Future.delayed(
          const Duration(milliseconds: 500), () => mapController.getMarkers()),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            return Column(children: [
              Expanded(
                child: Obx(() {
                  return GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onTap: (position) {
                      mapController
                          .customInfoWindowController.hideInfoWindow!();
                    },
                    initialCameraPosition: CameraPosition(
                        bearing: 192.8334901395799,
                        target: initialPosition,
                        tilt: 59.440717697143555,
                        zoom: 10.5),
                    onMapCreated: (controller) {
                      this.mapController.mapController = controller;
                    },
                    markers: this.mapController.markers.toSet(),
                    myLocationButtonEnabled: true,
                  );
                }),
              ),
              Obx(() {
                if (mapController.selectedVendorId.isNotEmpty) {
                  return GestureDetector(
                    child: Container(
                      color: ColorConstants
                          .mainScaffoldBackgroundColor, // Customize the background color
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                              height: 70.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                image: DecorationImage(
                                    image: NetworkImage(mapController
                                        .selectedVendorData['Image']),
                                    fit: BoxFit.cover),
                              )),
                          AppSizes.smallWidthSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mapText(mapController.selectedVendorData['Name']),
                              mapText(
                                  mapController.selectedVendorData['Category']),
                              AppSizes.xsmallHeightSizedBox,
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ]);
          } else if (snapShot.hasError) {
            return const Text("somthing went wrong");
          } else {
            return const Text("somthing went wrong");
          }
        } else {
          return const Center(child: MapTransition());
        }
      },
    );
  }
}
