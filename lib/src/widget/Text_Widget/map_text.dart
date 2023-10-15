import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

mapVendorText(String title) {
  return AutoSizeText(title.tr,
      maxLines: 2,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.mainTextColor)));
}

mapText(String title) {
  return AutoSizeText(title.tr,
      maxLines: 2,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)));
}
