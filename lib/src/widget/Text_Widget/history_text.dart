import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

historyMainTexrt(String title) {
  return Text(title.tr,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.mainTextColor)));
}

historyText(String title) {
  return Text(title.tr,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          textStyle:
              TextStyle(fontSize: 14.sp, color: ColorConstants.mainTextColor)));
}