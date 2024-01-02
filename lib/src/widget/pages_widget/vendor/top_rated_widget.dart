import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/model/vendor_model.dart';

import '../../../getx/dashboard_controller.dart';
import '../../custom_Widget.dart/location_widget.dart';

class TopRatedWidget extends StatelessWidget {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.getTopRated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final vendors = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendorName = vendors[index]['Name'];
                    final vendorImageURL = vendors[index]['Image'];
                    final vendorDescription = vendors[index]['Description'];

                    return Column(children: [
                      GestureDetector(
                        onTap: () => Get.to(
                            VendorPage(
                              vendor: VendorModel(
                                  name: vendorName,
                                  description: vendorDescription,
                                  image: vendorImageURL),
                            ),
                            transition: Transition.rightToLeft),
                        child: Container(
                          child: LocationWidget(
                            imageUrl: vendorImageURL,
                            name: vendorName,
                            description: vendorDescription,
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
