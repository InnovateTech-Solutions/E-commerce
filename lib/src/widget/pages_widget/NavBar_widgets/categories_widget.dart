import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/Products/products_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());

    return Center(
      child: FutureBuilder(
        future: firebaseservice.getAllCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> categories = snapshot.data!;
              categories.shuffle();
              return Column(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.r))),
                              child: Stack(
                                children: [
                                  DashboradContainer(
                                    imgName: categories[index]['image'],
                                    onTap: () => Get.to(ProductsPage(
                                      id: categories[index]['id'],
                                      title: categories[index]['Title'],
                                    )),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 140.h, left: 20.w),
                                    child: Text(categories[index]['Title'],
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
