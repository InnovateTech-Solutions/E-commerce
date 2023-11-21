import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

appBarText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(color: ColorConstants.greyColor, fontSize: 14)),
  );
}

dashoboardMainText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorConstants.mainTextColor,
            fontSize: 20.sp)),
  );
}

dashoboardSecText(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        textStyle: TextStyle(color: ColorConstants.greyColor, fontSize: 14.sp)),
  );
}
