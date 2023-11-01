import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/data_controller.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/category_item.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesTransition extends StatelessWidget {
  const CategoriesTransition({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(DataController());

    return Shimmer.fromColors(
        child: FutureBuilder(
          future: firebaseservice.fetchAllCategories(),
          builder: (context, snapshot) {
            final categories = snapshot.data!;
            categories.shuffle();
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: ((context, index) {
                        return CategoryItem(
                          category: categories[index],
                        );
                      })),
                ),
              ],
            );
          },
        ),
        baseColor: ColorConstants.mainScaffoldBackgroundColor,
        highlightColor: ColorConstants.secondaryScaffoldBacground);
  }
}
