import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/app_const.dart';

class LoginIcon extends StatelessWidget {
  const LoginIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            divder(150.w, 0.w, 20.w),
            Text("OR",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: ColorConstants.mainTextColor))),
            divder(150.w, 20.w, 0.w)
          ],
        ),
        SizedBox(
          height: AppConst.smallSize.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 120.w,
            ),
            SvgPicture.asset("assets/Google.svg"),
            SizedBox(width: AppConst.largeSize.w),
            SvgPicture.asset("assets/Apple.svg"),
          ],
        )
      ],
    );
  }
}
