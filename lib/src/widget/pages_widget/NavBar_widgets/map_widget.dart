import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/getx/map_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/transition/map_transition.dart';
import 'package:profile_part/src/widget/Text_Widget/map_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = Get.put(MapController());
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
                    onTap: () => Get.to(VendorPage(
                        vendor: VendorModel(
                            name: mapController.selectedVendorData['Name'],
                            description:
                                mapController.selectedVendorData['Description'],
                            image: mapController.selectedVendorData['Image']))),
                    child: Container(
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
                              Container(
                                width: 200.w,
                                child: mapVendorText(
                                    mapController.selectedVendorData['Name']),
                              ),
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
