import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vendor_app/src/constant/app_constant.dart';
import 'package:vendor_app/src/view/start_pages/forms/login_page.dart';
import 'package:vendor_app/src/view/start_pages/forms/register_page.dart';
import 'package:vendor_app/src/widget/constant_widget/sizes/const_wiidget/constant_widget.dart';
import 'package:vendor_app/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:vendor_app/src/widget/custom_widget.dart/button_widget.dart';

class SignUpInWidget extends StatelessWidget {
  const SignUpInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSizes.largeHeightSizedBox,
            SvgPicture.asset(
              "assets/IcareLogo.svg",
              width: 200.w,
              height: 90.h,
            ),
            constDivider(),
            SizedBox(
              height: 100.h,
            ),
            ButtonWidget(
                onTap: () {
                  Get.to(const LoginPage());
                },
                tilte: AppConst.login),
            SizedBox(
              height: AppConst.largeSize.h,
            ),
            ButtonWidget(
                onTap: () {
                  Get.to(const RegisterPage());
                },
                tilte: AppConst.signUp)
          ],
        ),
      ),
    );
  }
}
