import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

InkWell loginIcons({required String title, required Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: SvgPicture.asset(
      title,
      width: 50.w,
      height: 30.h,
    ),
  );
}
