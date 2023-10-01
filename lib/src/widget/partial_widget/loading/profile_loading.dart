import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatefulWidget {
  const ProfileLoading({super.key});

  @override
  State<ProfileLoading> createState() => _ProfileLoadingState();
}

class _ProfileLoadingState extends State<ProfileLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.secondaryScaffoldBacground,
      highlightColor: ColorConstants.mainScaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    color: ColorConstants.mainScaffoldBackgroundColor,
                  ),
                  AppSizes.smallHeightSizedBox,
                  Container(
                    width: 150.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  AppSizes.smallHeightSizedBox,
                  divder(115.w, 0, 0),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
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
                )),
          ],
        ),
      ),
    );
  }
}
