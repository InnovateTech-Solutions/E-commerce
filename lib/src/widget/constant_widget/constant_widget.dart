import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Container divder(double width, double left, double right) {
  return Container(
    height: 3.h,
    width: width,
    color: ColorConstants.secondaryScaffoldBacground,
    margin: EdgeInsets.only(right: right, left: left),
  );
}

InkWell loginIcons(String title, String destinationRoute) {
  return InkWell(
    onTap: () {
      Get.toNamed(destinationRoute);
    },
    child: SvgPicture.asset(
      title,
      width: 50.w,
      height: 30.h,
    ),
  );
}

dontHaveAccountRow() {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "don’t have account?",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.mainTextColor)),
        ),
        Text(
          "Create one",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.mainTextColor)),
        )
      ],
    ),
  );
}
