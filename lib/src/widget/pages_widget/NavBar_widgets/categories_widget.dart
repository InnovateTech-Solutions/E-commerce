import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/data_controller.dart';
import 'package:profile_part/src/model/categories_model.dart';
import 'package:profile_part/src/transition/categories_transition.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/category_item.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(DataController());

    return Center(
      child: FutureBuilder<List<Categories>>(
        future: Future.delayed(
          const Duration(milliseconds: 500),
          () => firebaseservice.fetchAllCategories(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
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
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            } else {
              return const Text("something went wrong");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CategoriesTransition();
          } else {
            return const Text("somthing went wrong");
          }
        },
      ),
    );
  }
}
