import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';

seeMore() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text('see more',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.mainTextColor))),
      IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_forward,
            size: 20,
            color: ColorConstants.mainTextColor,
          ))
    ],
  );
}
