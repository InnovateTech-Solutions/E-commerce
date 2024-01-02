import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/vendors_controller.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class SimilarWidget extends GetView {
  const SimilarWidget(
      {required this.category, required this.services, super.key});
  final String category;
  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    final VendorController vendorController =
        Get.put(VendorController(category));
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dashoboardMainText("Similer ${vendorController.vendorCategory}"),
          Obx(() {
            if (vendorController.vendors.isEmpty) {
              return Container(); // Show a loading indicator while data is loading.
            } else {
              return services.isEmpty
                  ? Container()
                  : Container(
                      height: 150.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return AppSizes.smallWidthSizedBox;
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: vendorController.vendors.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 175.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                color:
                                    ColorConstants.mainScaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2.r,
                                      blurRadius: 3.r,
                                      offset: const Offset(0, 2)),
                                ],
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 175.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0.r),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  vendorController
                                                      .vendors[index].image),
                                              fit: BoxFit.cover),
                                        )),
                                    AppSizes.xsmallHeightSizedBox,
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 60.h,
                                            width: double.infinity,
                                            child: subvendorText(
                                                vendorController
                                                    .vendors[index].name),
                                          ),
                                          Obx(() => vendorController
                                                      .vendors[index]
                                                      .averageRating
                                                      .toString() ==
                                                  'null'
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    secondaryConfirmText(
                                                      vendorController
                                                          .vendors[index]
                                                          .averageRating
                                                          .toString(),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 15,
                                                    )
                                                  ],
                                                )),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
                    );
            }
          }),
        ],
      ),
    );
  }
}
