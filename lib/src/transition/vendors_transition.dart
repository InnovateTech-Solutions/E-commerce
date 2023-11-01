import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class VendorsDisplayTransition extends StatelessWidget {
  const VendorsDisplayTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.secondaryScaffoldBacground,
      highlightColor: ColorConstants.mainScaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 18.w),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: ((context, index) {
            return Container(
              width: 300.w,
              height: 150.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: ColorConstants.mainScaffoldBackgroundColor),
            );
          }),
          separatorBuilder: (BuildContext context, int index) =>
              AppSizes.mediumHeightSizedBox,
        ),
      ),
    );
  }
}
