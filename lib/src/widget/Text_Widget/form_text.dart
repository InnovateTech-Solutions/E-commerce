import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../View/Forms/forhet_password_screen.dart';

mainText(String title) {
  return Center(
    child: Text(title.tr,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor))),
  );
}

textFieldLabel(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}

blueText(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}

greyText(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: ColorConstants.greyTextColor)));
}

TextButton textButton(Function()? onTap, String title) {
  return TextButton(onPressed: onTap, child: greyText(title));
}

forgetPasswordText(context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPwScreen()),
      );
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
