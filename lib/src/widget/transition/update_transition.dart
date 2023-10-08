import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class UpdateTransition extends StatelessWidget {
  const UpdateTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Center(
          child: Column(
            children: [
              AppSizes.smallHeightSizedBox,
              CircleAvatar(
                radius: 80.r,
              ),
              AppSizes.largeHeightSizedBox,
              SizedBox(
                height: 500.h,
                width: 300.h,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          color: ColorConstants.mainScaffoldBackgroundColor),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return AppSizes.mediumHeightSizedBox;
                  },
                ),
              ),
            ],
          ),
        ),
        baseColor: ColorConstants.mainScaffoldBackgroundColor,
        highlightColor: ColorConstants.secondaryScaffoldBacground);
  }
}
