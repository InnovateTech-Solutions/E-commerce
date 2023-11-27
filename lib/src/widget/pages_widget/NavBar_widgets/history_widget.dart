import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/helpers/actions/get_vendor_image.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/bookdetail_widget.dart';
import 'package:profile_part/src/widget/partial_widget/booking_partail/not_booked.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final controller = Get.put(BookingControllerAboutDate());

  @override
  void initState() {
    super.initState();
    controller.fetchBookingsUpcomming(UserController.instance.email.value);
    controller.fetchBookings(UserController.instance.email.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.bookingsToday.isEmpty && controller.bookings.isEmpty
          ? Center(
              child: Center(child: NohistoryWidget()),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  historyMainTexrt('Appointments'),
                  AppSizes.smallHeightSizedBox,
                  divder(320.w, 0, 0),
                  AppSizes.smallHeightSizedBox,
                  controller.bookingsToday.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            historyMainTexrt('Today Appointments'),
                            SizedBox(
                              height: 100.h * controller.bookingsToday.length,
                              width: double.infinity.w,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.bookingsToday.length,
                                itemBuilder: (context, index) {
                                  var bookingData =
                                      controller.bookingsToday[index].data()
                                          as Map<String, dynamic>;

                                  String str = bookingData['vendorName'];
                                  String first10Chars = str.substring(0, 10);
                                  String ellipsis = "...";
                                  String first10CharsWithEllipsis =
                                      first10Chars + ellipsis;
                                  return GestureDetector(
                                    onTap: () {
                                      showBookingInfo(
                                          context,
                                          bookingData['vendorName'],
                                          bookingData['date'],
                                          bookingData['time'],
                                          bookingData['price']);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              VendorImage(
                                                  image: bookingData[
                                                      'vendorName']),
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
                  AppSizes.smallHeightSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      historyMainTexrt('Upcomming Appointments'),
                      SizedBox(
                        height: 90.h * controller.bookings.length,
                        width: double.infinity.w,
                        child: ListView.builder(
                          itemCount: controller.bookings.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var bookingData = controller.bookings[index].data()
                                as Map<String, dynamic>;
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
                                                historyText(bookingData['time'])
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
                ],
              ),
            );
    });
  }
}
