import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';

import '../../../constant/app_const.dart';
import '../../../repository/authentication/authentication_repository.dart';

class LoginIcon extends StatelessWidget {
  LoginIcon({super.key});
  final controller = Get.put(AuthenticationRepository());

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
            loginIcons("assets/Google.svg", controller.signInWithGoogle),
            SizedBox(width: AppConst.largeSize.w),
            SvgPicture.asset("assets/Apple.svg"),
          ],
        )
      ],
    );
  }

  InkWell loginIcons(String title, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        title,
        width: 50.w,
        height: 30.h,
      ),
    );
  }
}
