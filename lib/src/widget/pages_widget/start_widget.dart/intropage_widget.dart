import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/Forms/login_page.dart';
import 'package:profile_part/src/View/Forms/register_page.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: AppConst.largeSize.h,
            ),
            SvgPicture.asset(
              "assets/Logo.svg",
              width: 200.w,
              height: 90.h,
            ),
            constDivider(),
            SizedBox(
              height: 100.h,
            ),
            ButtonWidget(
                onTap: () => Get.to(const LoginPage()), tilte: AppConst.login),
            SizedBox(
              height: AppConst.largeSize.h,
            ),
            ButtonWidget(
                onTap: () => Get.to(const RegisterPage()),
                tilte: AppConst.signUp),
          ],
        ),
      ),
    );
  }
}
