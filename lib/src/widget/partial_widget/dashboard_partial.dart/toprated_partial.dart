import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/Text_Widget/dashboard_text.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';

import '../../../getx/dashboard_controller.dart';
import '../../custom_Widget.dart/dashboard_title.dart';

class TopRated extends StatelessWidget {
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
              DashboardTitle("Top Rated", () {}),
              SizedBox(
                width: 350.w,
                height: 250.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final vendorName = vendors[index]['Name'];
                    final vendorImageURL = vendors[index]['Image'];
                    final vendorCategory = vendors[index]['Category'];
                    final vendorDescription = vendors[index]['Description'];
                    //      RxDouble vendorRate = vendors[index]['averageRating'].obs;

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  ColorConstants.mainScaffoldBackgroundColor),
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 250.w,
                                  height: 150.h,
                                  child: AppContainer(
                                      imgName: vendorImageURL,
                                      onTap: () {
                                        Get.to(VendorPage(
                                          vendor: VendorModel(
                                              name: vendorName,
                                              description: vendorDescription,
                                              image: vendorImageURL),
                                        ));
                                      })),
                              AppSizes.xsmallHeightSizedBox,
                              Row(
                                children: [
                                  AppSizes.smallWidthSizedBox,
                                  textFieldLabel(
                                    vendorName,
                                  ),
                                ],
                              ),
                              // Obx(() => vendorRate.toString() == 'null'
                              //     ? Container()
                              //     : Row(
                              //         children: [
                              //           secondaryConfirmText(
                              //             vendorRate.toString(),
                              //           ),
                              //           Icon(
                              //             Icons.star,
                              //             color: Colors.yellow,
                              //             size: 15,
                              //           )
                              //         ],
                              //       ))

                              dashoboardSecText(
                                vendorCategory,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
