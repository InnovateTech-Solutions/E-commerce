/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icare_vendor_app/getx/map_controller.dart';
import 'package:icare_vendor_app/widget/text_widget/form_text.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: mapController.markers,
          initialCameraPosition: const CameraPosition(
              target: LatLng(37.422131, -122.084801),
              tilt: 59.440717697143555,
              zoom: 10.5),
          onMapCreated: (controller) {
            mapController.mapController = controller;
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            mapController.position();
            print(mapController.pos);
          },
          label: textFieldLabel("Current location"),
          icon: const Icon(Icons.location_history),
        ),
      ),
    );
  }
}


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class filePicker extends StatefulWidget {
  const filePicker({super.key});

  @override
  State<filePicker> createState() => _filePickerState();
}

class _filePickerState extends State<filePicker> {
  TextEditingController filePathController = TextEditingController();
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // You can specify the file type you want to pick
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'txt'
      ], // Example file extensions
    );

    if (result != null) {
      String filePath = result.files.first.path!;
      filePathController.text = filePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Picker Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openFilePicker,
              child: Text("Open File Picker"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

    Future<Position> position() async {
    Position position = await determinePosition();
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        ),
      ),
    );

    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("currentLocation"),
      position: LatLng(position.latitude, position.longitude),
    ));
    updateMarkerPosition(position.latitude, position.longitude);
    print(position);
    pos.value = position.toString();
    return position;
  }
}*/
