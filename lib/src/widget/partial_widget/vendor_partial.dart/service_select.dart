import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

serviceSelcet(String serviceName, int mainindex, int selectedIndex) {
  return Container(
    width: 120.w,
    height: 60.h,
    decoration: BoxDecoration(
      color: selectedIndex == mainindex ? Colors.white70 : Colors.white54,
      borderRadius: selectedIndex == mainindex
          ? BorderRadius.circular(15.r)
          : BorderRadius.circular(10.r),
      border: selectedIndex == mainindex
          ? Border.all(color: ColorConstants.mainTextColor, width: 2.w)
          : null,
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 3.h),
        child: Text(
          serviceName,
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: selectedIndex == mainindex ? Colors.black : Colors.grey),
        ),
      ),
    ),
  );
}
