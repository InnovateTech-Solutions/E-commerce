import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/helpers/actions/get_vendor_image.dart';
import 'package:profile_part/src/model/booking_model.dart';
import 'package:profile_part/src/widget/Text_Widget/booking_text.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class ShowBookingInfo extends StatelessWidget {
  const ShowBookingInfo({super.key, required this.booking});
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: thirdAppBar(),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VendorImage(
                  height: 150.h,
                  width: double.infinity,
                  image: booking.vendorName),
              bookingMainText(booking.vendorName),
              phoneText(() {}, "078963524"),
              AppSizes.mediumHeightSizedBox,
              dateText("${booking.date} at ${booking.time}"),
              noteText("Your Note: ${booking.note}"),
              AppSizes.smallHeightSizedBox,
              dateText("Srvices"),
              AppSizes.smallHeightSizedBox,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: booking.services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          serviceText(booking.services[index]),
                          AppSizes.smallHeightSizedBox,
                          Divider(
                            height: 5,
                            color: ColorConstants.greyColor,
                          ),
                          AppSizes.smallHeightSizedBox,
                        ]);
                  },
                ),
              ),
              Spacer(),
              textFieldLabel("Price: ${booking.totalPrice.toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}









// final controller = Get.put(BookingControllerAboutDate());

// void showBookingInfo(BuildContext context, String vendorName,
//     String bookingDate, String bookingTime, String price) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(32.0))),
//         content:      );
//     },
//   );
// }
