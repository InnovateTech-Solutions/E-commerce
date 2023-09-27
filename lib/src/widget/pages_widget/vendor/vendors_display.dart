import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/getx/data_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

class VendorDisplayWidget extends StatefulWidget {
  const VendorDisplayWidget({Key? key, required this.category})
      : super(key: key);

  final String category;
  @override
  State<VendorDisplayWidget> createState() => _VendorDisplayWidgetState();
}

class _VendorDisplayWidgetState extends State<VendorDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(DataController());
    return FutureBuilder<List<VendorModel>>(
      future: firebaseservice.fetchVendorByCategory(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final vendor = snapshot.data!;
            vendor.shuffle();
            return Column(children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: vendor.length,
                    itemBuilder: ((context, index) {
                      return Column(children: [
                        GestureDetector(
                          onTap: () => Get.to(VendorPage(
                            vendor: vendor[index],
                          )),
                          child: LocationWidget(
                            imageUrl: vendor[index].image,
                            name: vendor[index].name,
                            description: vendor[index].description,
                          ),
                        ),
                      ]);
                    })),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error${snapshot.error}'));
          } else {
            return const Text("something went wrong");
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Text("something went wrong");
        }
      },
    );
  }
}
