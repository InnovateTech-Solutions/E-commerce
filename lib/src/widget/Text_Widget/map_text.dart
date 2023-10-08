import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

mapText(String title) {
  return Center(
    child: Text(title.tr,
        softWrap: true,
        overflow: TextOverflow.visible,
        maxLines: null,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor))),
  );
}
