import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/service_select.dart';

class Service extends GetView<Appcontroller> {
  const Service(
      {required this.serviceName,
      required this.serviceDescription,
      required this.servicePrice,
      required this.length,
      super.key});

  final String serviceName;
  final String servicePrice;
  final String serviceDescription;

  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 85.h,
          width: double.infinity,
          child: ListView.separated(
              separatorBuilder: (context, index) => AppSizes.smallWidthSizedBox,
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (context, index) {
                return Obx(
                  () => Column(
                    children: [
                      GestureDetector(
                          onTap: () => controller.currentIndex.value = index,
                          child: serviceSelcet(serviceName, index,
                              controller.currentIndex.value)),
                    ],
                  ),
                );
              }),
        ),
        Builder(builder: (context) {
          return length == 0
              ? Center(
                  child: mainText('No Service Available'),
                )
              : Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      subvendorText(serviceDescription),
                      AppSizes.mediumHeightSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductButton(onTap: () => null),
                          subvendorText(
                            servicePrice,
                          )
                        ],
                      )
                    ],
                  ),
                );
        })
      ],
    );
  }
}
