import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/Text_Widget/pastlogin_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

GestureDetector continueContainer(
    {required String title,
    required String imgname,
    required VoidCallback callback}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: ColorConstants.mainScaffoldBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.r,
              blurRadius: 3.r,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imgname,
            width: 30.w,
            height: 30.h,
          ),
          AppSizes.mediumWidthSizedBox,
          secondaryPastLoginText(title),
        ],
      ),
    ),
  );
}

GestureDetector onLoginContainer(
    {required String title, required Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: ColorConstants.mainScaffoldBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.r,
              blurRadius: 3.r,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Center(
        child: secondaryPastLoginText(title),
      ),
    ),
  );
}
