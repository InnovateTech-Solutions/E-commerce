import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class DeleteAccountTransition extends StatelessWidget {
  const DeleteAccountTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Center(
        child: Column(
          children: [
            AppSizes.largeHeightSizedBox,
            AppSizes.largeHeightSizedBox,
            transitionContainer(250.w),
            AppSizes.largeHeightSizedBox,
            transitionContainer(300.w),
            AppSizes.mediumHeightSizedBox,
            transitionContainer(300.w),
            AppSizes.mediumHeightSizedBox,
            transitionContainer(250.w)
          ],
        ),
      ),
      baseColor: ColorConstants.mainScaffoldBackgroundColor,
      highlightColor: ColorConstants.secondaryScaffoldBacground,
    );
  }

  Container transitionContainer(double width) {
    return Container(
      width: width,
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14.r)),
          color: Colors.black),
    );
  }
}
