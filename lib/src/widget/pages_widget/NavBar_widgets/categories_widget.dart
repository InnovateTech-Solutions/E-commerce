import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../View/Products/products_page.dart';
import '../../../constant/color.dart';
import '../../../getx/data_controller.dart';
import '../../../model/categories_model.dart';
import '../../custom_Widget.dart/container_widget.dart';

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
        future: firebaseservice.fetchAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              categories.shuffle();
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                        height: 520.h,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 2,
                            ),
                            itemBuilder: ((context, index) {
                              return Container(
                                width: 150.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14.r))),
                                child: Stack(
                                  children: [
                                    AppContainer(
                                      imgName: categories[index].image,
                                      onTap: () => Get.to(ProductsPage(
                                        title: categories[index].title,
                                      )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 140.h, left: 20.w),
                                      child: Text(categories[index].title,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants
                                                      .mainScaffoldBackgroundColor))),
                                    )
                                  ],
                                ),
                              );
                            }))),
                  ],
                ),
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
            return const Text("somthing went wrong");
          }
        },
      ),
    );
  }
}
