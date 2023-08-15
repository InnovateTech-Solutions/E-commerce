import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_const.dart';
import '../Text_Widget/form_text.dart';

class LoginIcon extends StatelessWidget {
  const LoginIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            divder(150.w, 0.w, 20.w),
            thirdText("OR"),
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
            loginIcons("assets/Google.svg", "destinationRoute"),
            SizedBox(width: AppConst.largerSize),
            loginIcons("assets/Apple.svg", "destinationRoute")
          ],
        )
      ],
    );
  }
}
