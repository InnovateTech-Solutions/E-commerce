import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';

priceAndConfirm(int totalPrice, int serviceLength) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: double.infinity.w,
      height: 75.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.r,
                blurRadius: 3.r,
                offset: const Offset(0, 2)),
          ],
          color: ColorConstants.mainScaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BD ${totalPrice}",
                style: TextStyle(
                  color: ColorConstants.mainTextColor, // Customize text color
                  fontSize: 16.0.sp, // Customize text size
                ),
              ),
              Text(
                '${serviceLength} Service',
                style: TextStyle(
                    color: ColorConstants.mainTextColor, // Customize text color
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.w300
                    // Customize text size
                    ),
              ),
            ],
          ),
          ProductButton(
            onTap: () => {},
            title: 'Confrim',
          )
        ],
      ),
    ),
  );
}
