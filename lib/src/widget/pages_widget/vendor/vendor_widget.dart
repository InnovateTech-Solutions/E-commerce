import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/test/home_controller.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/header_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/rating_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/service_select.dart';

class VendorWidget extends GetView<Appcontroller> {
  const VendorWidget({required this.vendor, super.key});
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    Get.put(Appcontroller());
    return FutureBuilder(
        future: FirebaseService.instance.fetchServicebyName(vendor.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;

              return CustomScrollView(slivers: [
                SliverAppBar(
                    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 300.h,
                    flexibleSpace: FlexibleSpaceBar(
                      background: headerWidget(vendor.image),
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    height: 500.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                        color: ColorConstants.mainScaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15.0.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2.r,
                              blurRadius: 3.r,
                              offset: const Offset(0, 2)),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppSizes.smallHeightSizedBox,
                          vendor.name.length > 30
                              ? mainVendorText(vendor.name)
                              : Row(
                                  children: [
                                    mainVendorText(vendor.name),
                                  ],
                                ),
                          AppSizes.xsmallHeightSizedBox,
                          ratingBarIndicator('4', '150'),
                          AppSizes.xsmallHeightSizedBox,
                          addressText(vendor.coordinates, vendor.address),
                          AppSizes.smallHeightSizedBox,
                          serviceText(),
                          AppSizes.smallHeightSizedBox,
                          SizedBox(
                            height: 85.h,
                            width: double.infinity,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    AppSizes.smallWidthSizedBox,
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () => controller
                                                .currentIndex.value = index,
                                            child: serviceSelcet(
                                                data[index]['Name'],
                                                index,
                                                controller.currentIndex.value)),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Builder(builder: (context) {
                            return data.isEmpty
                                ? Center(
                                    child: mainText('No Service Available'),
                                  )
                                : Obx(
                                    () => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        subvendorText(
                                            data[controller.currentIndex.value]
                                                ['Description']),
                                        AppSizes.mediumHeightSizedBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ProductButton(onTap: () => null),
                                            subvendorText(data[controller
                                                .currentIndex.value]['Price']),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                          })
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            } else {
              return const Text("something went wrong");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: ColorConstants.mainScaffoldBackgroundColor,
              value: 0.5,
            ));
          } else {
            return const Text("something went wrong");
          }
        });
  }
}
