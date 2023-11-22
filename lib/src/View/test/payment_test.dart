import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/vendorimage_controller.dart';
import 'package:profile_part/src/getx/vendors_controller.dart';

class VendorImageScreen extends StatelessWidget {
  final VendorImage vendorController = Get.put(VendorImage());
  final TextEditingController vendorNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: vendorNameController,
              decoration: InputDecoration(labelText: 'Enter Vendor Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String vendorName = vendorNameController.text.trim();
                if (vendorName.isNotEmpty) {
                  vendorController.getImageName(vendorName);
                }
              },
              child: Text('Get Image Name'),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (vendorController.imageName.isNotEmpty) {
                return Image.network(
                  // Assuming the images are stored in a specific location, replace 'your_base_url' accordingly
                  vendorController.imageName.value,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                );
              } else {
                return Container(); // Placeholder or alternative UI for no image
              }
            }),
            SizedBox(height: 16),
            Obx(() {
              if (vendorController.imageName.isNotEmpty) {
                return Text(
                  'Image Name: ${vendorController.imageName}',
                  style: TextStyle(fontSize: 16),
                );
              } else {
                return Text(
                  'Vendor not found or image name is null.',
                  style: TextStyle(fontSize: 16),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    GetMaterialApp(
      home: VendorImageScreen(),
    ),
  );
}
