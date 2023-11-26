import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller1.dart';
import 'package:profile_part/src/widget/Text_Widget/booking_text.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

final controller = Get.put(UpBookingController());

void showBookingInfo(BuildContext context, int index) {
  DocumentSnapshot snapshot = controller.snapshots[index];
  Map<String, dynamic> bookingData = snapshot.data() as Map<String, dynamic>;
  String str = bookingData['vendorName'];
  String first10Chars = str.substring(0, 15);
  String ellipsis = "...";
  String first10CharsWithEllipsis = first10Chars + ellipsis;
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
              bookingMainText(bookingData['vendorName']),
              phoneText(() {}, "078963524"),
              AppSizes.mediumHeightSizedBox,
              Center(
                child: Column(
                  children: [
                    dateText(bookingData['date']),
                    timeText(bookingData['time']),
                  ],
                ),
              ),
              Spacer(),
              textFieldLabel("Total Price: ${bookingData['totalPrice']}")
            ],
          ),
        ),
      );
    },
  );
}
