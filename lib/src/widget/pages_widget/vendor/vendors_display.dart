import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/getx/data_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/transition/vendors_transition.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

class VendorDisplayWidget extends GetView {
  const VendorDisplayWidget({Key? key, required this.category})
      : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(DataController());
    return FutureBuilder<List<VendorModel>>(
      future: Future.delayed(
        const Duration(seconds: 1),
        () => firebaseservice.fetchVendorByCategory(category),
      ),
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
                          onTap: () => Get.to(
                              VendorPage(
                                vendor: vendor[index],
                              ),
                              transition: Transition.rightToLeft),
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
            child: VendorsDisplayTransition(),
          );
        } else {
          return const Text("something went wrong");
        }
      },
    );
  }
}
