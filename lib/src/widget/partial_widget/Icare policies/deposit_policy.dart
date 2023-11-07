import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';

class Deposit {
  static Container title() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      alignment: Alignment.centerLeft,
      child: mainConfirmText('Deposit policy'),
    );
  }

  static Container content() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Text(
        'As part of our commitment to delivering quality care services, iCare App requires a deposit of 10% of the total invoice amount. This deposit is necessary to secure your service reservation and initiate the scheduling process. The deposit is applicable to all services offered by iCare App.',
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.mainTextColor)),
      ),
    );
  }
}
