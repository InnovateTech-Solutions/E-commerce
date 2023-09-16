import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    return FutureBuilder(
      future: firebaseservice.getServicesByCategory(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> products = snapshot.data!;
            products.shuffle();
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 690.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => print(products.length),
                                  child: LocationWidget(
                                    imageUrl: products[index]['Image'],
                                    name: products[index]['Name'],
                                    description: products[index]['Description'],
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
