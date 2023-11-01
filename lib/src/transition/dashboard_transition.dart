import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class DashboardTransition extends StatelessWidget {
  const DashboardTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorConstants.mainScaffoldBackgroundColor,
        highlightColor: ColorConstants.secondaryScaffoldBacground,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 250.w,
                  height: 186.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: ColorConstants.mainScaffoldBackgroundColor),
                ),
                AppSizes.mediumHeightSizedBox,
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Container(
                            width: 150.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.r)),
                                color: Colors.black),
                            child: Stack(children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 6.0.h, horizontal: 6.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0.r),
                                ),
                              ),
                            ])),
                      );
                    }))
              ],
            ),
          ),
        ));
  }
}
