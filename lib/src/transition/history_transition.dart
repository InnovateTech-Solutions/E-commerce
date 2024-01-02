import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

import '../widget/partial_widget/booking_partail/not_booked.dart';

class HistoryTransition extends StatefulWidget {
  const HistoryTransition({super.key});

  @override
  State<HistoryTransition> createState() => _HistoryTransitionState();
}

class _HistoryTransitionState extends State<HistoryTransition> {
  final controller = Get.put(BookingControllerAboutDate());

  void initState() {
    super.initState();

    controller.fetchBookingsUpcomming(UserController.instance.email.value);
    controller.fetchBookings(UserController.instance.email.value);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorConstants.mainTextColor,
        highlightColor: ColorConstants.secondaryScaffoldBacground,
        child: Obx(() {
          return controller.bookingsToday.isEmpty && controller.bookings.isEmpty
              ? Center(
                  child: Center(child: NohistoryWidget()),
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: ColorConstants.secondaryScaffoldBacground,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      AppSizes.smallHeightSizedBox,
                      divder(320.w, 0, 0),
                      AppSizes.smallHeightSizedBox,
                      controller.bookingsToday.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                      color: ColorConstants
                                          .secondaryScaffoldBacground,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                ),
                                SizedBox(
                                  height:
                                      100.h * controller.bookingsToday.length,
                                  width: double.infinity.w,
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.bookingsToday.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 300.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            color: ColorConstants
                                                .secondaryScaffoldBacground,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return AppSizes.smallHeightSizedBox;
                                    },
                                  ),
                                ),
                              ],
                            ),
                      AppSizes.smallHeightSizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color:
                                    ColorConstants.secondaryScaffoldBacground,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                          SizedBox(
                            height: 100.h * controller.bookings.length,
                            width: double.infinity.w,
                            child: ListView.builder(
                              itemCount: controller.bookings.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 300.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      color: ColorConstants
                                          .secondaryScaffoldBacground,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        }));
  }
}
