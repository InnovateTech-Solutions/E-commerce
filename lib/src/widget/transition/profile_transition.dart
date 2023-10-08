import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class ProfileTransition extends StatefulWidget {
  const ProfileTransition({super.key});

  @override
  State<ProfileTransition> createState() => _ProfileTransitionState();
}

class _ProfileTransitionState extends State<ProfileTransition> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.secondaryScaffoldBacground,
      highlightColor: ColorConstants.mainScaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 80.r,
                ),
                AppSizes.smallHeightSizedBox,
                divder(115.w, 0, 0),
              ],
            ),
            AppSizes.smallHeightSizedBox,
            SizedBox(
              height: 300.h,
              width: 350.w,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 50,
                    height: 50,
                    color: ColorConstants.mainScaffoldBackgroundColor,
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
    );
  }
}
