import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/getx/reviews_controller.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/rating_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/service_select.dart';

class Vendor {
  static Column displayName(String vendorname) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vendorname.length > 30
            ? mainVendorText(vendorname)
            : Row(
                children: [
                  mainVendorText(vendorname),
                ],
              )
      ],
    );
  }

  static Column ratingBar(String vendor) {
    final reviewsController = Get.put(ReviewsController(vendor));
    return Column(
      children: [
        Obx(() => reviewsController.reviews.length == 0
            ? ratingBarIndicator('0', '0')
            : ratingBarIndicator(reviewsController.averageRating.toString(),
                reviewsController.reviews.length.toString())),
      ],
    );
  }

  static SizedBox serviceListName(List<ServiceModel> services) {
    final controller = Get.put(Appcontroller());
    return SizedBox(
      height: 85.h,
      width: double.infinity,
      child: ListView.separated(
          separatorBuilder: (context, index) => AppSizes.smallWidthSizedBox,
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Obx(
              () => Column(
                children: [
                  GestureDetector(
                      onTap: () => {controller.currentIndex.value = index},
                      child: serviceSelcet(services[index].name, index,
                          controller.currentIndex.value)),
                ],
              ),
            );
          }),
    );
  }

  static Builder serviceDisplay(List<ServiceModel> services) {
    final controller = Get.put(Appcontroller());
    final cartController = Get.put(ServiceController());
    return Builder(builder: (context) {
      return services.isEmpty
          ? Center(
              child: mainText('No Service Available'),
            )
          : Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  subvendorText(
                      services[controller.currentIndex.value].description),
                  AppSizes.mediumHeightSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProductButton(
                        onTap: () => {
                          cartController.toggleService(
                              services[controller.currentIndex.value]),
                          print(
                              '${services[controller.currentIndex.value].isSelected}  + ${controller.currentIndex.value}'),
                        },
                        title: 'Book',
                      ),
                      subvendorText(
                          services[controller.currentIndex.value].price),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
