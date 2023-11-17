import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

mainPastLoginText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)));
}

secondaryPastLoginText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)));
}
