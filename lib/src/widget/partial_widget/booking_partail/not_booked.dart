import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/categories_page.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';

class NohistoryWidget extends StatelessWidget {
  const NohistoryWidget({super.key});

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
