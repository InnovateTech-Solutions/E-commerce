import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.0.h),
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
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            height: 70.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                color:
                                    ColorConstants.secondaryScaffoldBacground)),
                        AppSizes.smallWidthSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            historyText("title"),
                            historyText("title")
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
