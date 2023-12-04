// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_display.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/dashboard_title.dart';

import '../../../repository/service_repository/service_data.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {required this.imgName, required this.onTap, Key? key})
      : super(key: key);
  final String imgName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: Center(child: SvgPicture.network(imgName)),
      ),
    );
  }
}

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());
    RxBool seeMore = false.obs;
    RxInt itemCont = 3.obs;

    return FutureBuilder(
        future: firebaseservice.fetchAdsAndCategories(),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.done) {
            if (snpshot.hasData) {
              final categories = snpshot.data!['categories'];
              categories!.shuffle();

              return Column(
                children: [
                  DashboardTitle("Trending Categories", () {
                    seeMore.toggle();
                    if (seeMore.isTrue) {
                      itemCont(categories.length);
                    } else {
                      itemCont(3);
                    }
                  }),
                  Obx(
                    () => seeMore == true
                        ? SizedBox(
                            width: 350.w,
                            height: 330.h,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemCont.value,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 70.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.r))),
                                      child: Center(
                                          child: GestureDetector(
                                        onTap: () => Get.to(
                                            VendorDisplaypage(
                                                title: categories[index]
                                                    ['Title']),
                                            transition: Transition.rightToLeft),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 6.0.h,
                                              horizontal: 6.0.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0.r),
                                          ),
                                          child: Center(
                                              child: SvgPicture.network(
                                                  categories[index]['Icon'])),
                                        ),
                                      )),
                                    ),
                                    Container(
                                      child: textFieldLabel(
                                        categories[index]['Title'],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 350.w,
                            height: 100.h,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemCont.value,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 70.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.r))),
                                      child: Center(
                                        child: CategoryContainer(
                                          imgName: categories[index]['Icon'],
                                          onTap: () => Get.to(
                                              VendorDisplaypage(
                                                  title: categories[index]
                                                      ['Title']),
                                              transition:
                                                  Transition.rightToLeft),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: textFieldLabel(
                                        categories[index]['Title'],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                            )),
                  ),
                ],
              );
            } else if (snpshot.hasError) {
              return Text('Erorr${snpshot.error}');
            } else {
              return const Text("somthing went wrong");
            }
          } else if (snpshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return const Text("somthing went wrong");
          }
        });
  }
}
