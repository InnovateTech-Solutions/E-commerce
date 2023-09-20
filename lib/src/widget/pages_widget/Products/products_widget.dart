import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/getx/data_controller.dart';
import 'package:profile_part/src/model/product_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key, required this.category}) : super(key: key);

  final String category;
  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());
    return FutureBuilder<List<Product>>(
      future: firebaseservice.fetchVendorByCategory(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // final products = snapshot.data!;
            // products.shuffle();
            return Column(
              children: [
                TextField(
              onChanged: (value) => firebaseservice.filterPlayer(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 690.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: firebaseservice.products.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(VendorPage(
                                    product: firebaseservice.products[index],
                                  )),
                                  child: LocationWidget(
                                    imageUrl: firebaseservice.products[index].image,
                                    name: firebaseservice.products[index].name,
                                    description: firebaseservice.products[index].description,
                                  ),
                                ),
                              ],
                            );
                          })),
                    ),
                  ),
                ),
              ],
            );
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
