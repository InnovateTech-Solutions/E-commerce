import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

loginMainText() {
  return Center(
    child: Text("LOGIN",
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor))),
  );
}

textfiledLabel(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.sp,
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
