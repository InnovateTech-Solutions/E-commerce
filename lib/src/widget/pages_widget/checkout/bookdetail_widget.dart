import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/widget/Text_Widget/booking_text.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

void showBookingInfo(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          height: 200.h,
          width: 200.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //vendor name
              bookingMainText("opal Nail Salon "),
              phoneText(() {}, "078963524"),
              AppSizes.mediumHeightSizedBox,
              Center(
                child: Column(
                  children: [
                    dateText("1 aug 2023 at 15:00"),
                    timeText("1h 30min duration")
                  ],
                ),
              ),
              Spacer(),
              textFieldLabel("Price: 35.5")
            ],
          ),
        ),
      );
    },
  );
}
