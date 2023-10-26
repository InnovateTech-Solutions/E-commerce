import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/user_actions/actions/user_actions.dart';

mainVendorText(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.mainTextColor)));
}

subvendorText(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)));
}

addressText(String? coordinates, String? address) {
  return Container(
    alignment: Alignment.centerLeft,
    child: GestureDetector(
      onTap: () => launchMap(coordinates),
      child: Text(address ?? 'No location available'.tr,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.mainTextColor))),
    ),
  );
}

serviceText() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text('Service'.tr,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.mainTextColor))),
  );
}
