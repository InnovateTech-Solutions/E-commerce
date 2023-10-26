import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

mainConfirmText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.mainTextColor)));
}

secondaryConfirmText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)));
}

thirdConfirmText(String? title) {
  return Text(
    title ?? 'There is no address ',
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorConstants.mainTextColor, // Customize text color
          fontSize: 10.0.sp,
          fontWeight: FontWeight.w300
          // Customize text size
          ),
    ),
  );
}

payText(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              color: ColorConstants.subTextColor)));
}
