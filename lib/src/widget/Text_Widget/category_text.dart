import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

Text categoriesText(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainScaffoldBackgroundColor)));
}
