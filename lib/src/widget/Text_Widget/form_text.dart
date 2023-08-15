import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

FirstText(String title) {
  return Center(
    child: Text(title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor))),
  );
}

secText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}

thirdText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}

forgetPaawordText() {
  return GestureDetector(
    onTap: () {},
    child: Text(
      "Forgot Password?",
      textAlign: TextAlign.end,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)),
    ),
  );
}
