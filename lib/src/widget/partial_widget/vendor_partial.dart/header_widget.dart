import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

headerWidget(String image) {
  return Container(
      height: 250.h,
      width: double.infinity.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r)),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ));
}
