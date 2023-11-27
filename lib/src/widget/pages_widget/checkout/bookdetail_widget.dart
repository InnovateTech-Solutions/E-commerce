import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/widget/Text_Widget/booking_text.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

final controller = Get.put(BookingControllerAboutDate());

void showBookingInfo(BuildContext context, String? vendorName,
    String? bookingDate, String? bookingTime, String? price) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          height: 200.h,
          width: double.infinity.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //vendor name
              bookingMainText(vendorName!),
              phoneText(() {}, "078963524"),
              AppSizes.mediumHeightSizedBox,
              Center(
                child: Column(
                  children: [
                    dateText(bookingDate!),
                    timeText(bookingTime!),
                  ],
                ),
              ),
              Spacer(),
              textFieldLabel(price!)
            ],
          ),
        ),
      );
    },
  );
}
