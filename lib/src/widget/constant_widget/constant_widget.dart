import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

constDivider() {
  return Divider(
    thickness: 3,
    color: ColorConstants.secondaryScaffoldBacground,
    indent: 20,
    endIndent: 30,
  );
}

dontHaveAccountRow() {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "don’t have account?",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.mainTextColor)),
        ),
        Text(
          "Create one",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.mainTextColor)),
        )
      ],
    ),
  );
}
