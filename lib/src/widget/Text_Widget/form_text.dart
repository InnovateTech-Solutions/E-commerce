import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import '../../View/Forms/forgot_password_screen.dart';

mainText(String title) {
  return Center(
    child: Text(title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor))),
  );
}

textFieldLabel(String title) {
  return Text(title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}

forgetPasswordText(context) {
  return GestureDetector(
    onTap: () {
      Get.to(const ForgotPwScreen());
    },
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