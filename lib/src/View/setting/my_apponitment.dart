import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/helpers/actions/get_vendor_image.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class MyAppointment extends StatefulWidget {
  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  final BookingControllerAboutDate controller =
      Get.put(BookingControllerAboutDate());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return controller.allbookings.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        historyMainTexrt('my Appointments'),
                        AppSizes.smallHeightSizedBox,
                        divder(320.w, 0, 0),
                        AppSizes.smallHeightSizedBox,
                        SizedBox(
                          height: 90.h * controller.allbookings.length,
                          width: double.infinity.w,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.allbookings.length,
                            itemBuilder: (context, index) {
                              var bookingData = controller.allbookings[index]
                                  .data() as Map<String, dynamic>;
                              String str = bookingData['vendorName'];
                              String first10Chars = str.substring(0, 10);
                              String ellipsis = "...";
                              String first10CharsWithEllipsis =
                                  first10Chars + ellipsis;

                              return GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          VendorImage(
                                              image: bookingData['vendorName']),
                                          AppSizes.smallWidthSizedBox,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              historyText(
                                                  first10CharsWithEllipsis),
                                              Row(
                                                children: [
                                                  historyText(
                                                      bookingData['date']),
                                                  SizedBox(width: 80.w),
                                                  historyText(
                                                      bookingData['time'])
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
