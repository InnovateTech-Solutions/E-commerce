import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/getx/search_controller.dart';
import 'package:profile_part/src/model/product_model.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

class ProductsWidget extends GetView<SearchControllerr> {
  const ProductsWidget(this.category, {super.key});

  final String category;
  

  @override
  Widget build(BuildContext context) {
     Get.put(SearchControllerr(category));

            return Column(
              children: [
              TextField(
              onChanged: (value) { controller.filterPlayer(value); },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 690.h,
                      child: Obx( 
                        () => ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.filteredList.length,
                          itemBuilder: ((context, index) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(VendorPage(
                                    product: controller.filteredList[index],
                                  )),
                                  child: LocationWidget(
                                    imageUrl: controller.filteredList[index].image,
                                    name: controller.filteredList[index].name,
                                    description: controller.filteredList[index].description,
                                  ),
                                ),
                              ],
                            )
                          )), 
                        ),
                    ),
                  ),
                ),
              ],
            );
  }
}
