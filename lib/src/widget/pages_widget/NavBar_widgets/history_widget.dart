/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return Center(
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 500)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.0.h),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      historyMainTexrt("My Appointments"),
                      AppSizes.smallHeightSizedBox,
                      divder(320.w, 0, 0),
                      AppSizes.smallHeightSizedBox,
                      /* Builder(builder: (context) {
                                return data.isEmpty
                                    ? Column(
                                        children:[ historyMainTexrt('No Upcoming Appointments'),
                                         AppSizes.smallHeightSizedBox,
                                        historyText("you do not hane upcoming appointment. once you do, they will show up here. now get booking")],
                                        historyText("Past Appointments")],                                  
                                      )
                                    :historyMainTexrt('Upcoming Appointments');*/

                      historyMainTexrt('Upcoming\nAppointments'),
                      AppSizes.smallHeightSizedBox,
                      SizedBox(
                        height: 350.h,
                        width: 350.w,
                        child: ListView.separated(
                          itemBuilder: ((context, Index) {
                            return historyContainer(controller.history[Index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return AppSizes.mediumHeightSizedBox;
                          },
                          itemCount: controller.history.length,
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            } else {
              return const Text("something went wrong");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Text("somthing went wrong");
          }
        },
      ),
    );
  }
}




*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/categories_page.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 500.h,
        child: ListView(
          children: [
            SvgPicture.asset("assets/booking.svg"),
            AppSizes.largeHeightSizedBox,
            historyMainTexrt("No Appointment\nBooked"),
            AppSizes.xsmallHeightSizedBox,
            historyText("You have not booked any\n appointment yet."),
            AppSizes.smallHeightSizedBox,
            ButtonWidget(
                onTap: () {
                  Get.to(CategoriesPage());
                },
                title: "Book Now")
          ],
        ),
      ),
    );
  }
}
