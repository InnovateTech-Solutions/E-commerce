import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class VendorLoading extends StatelessWidget {
  const VendorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.mainScaffoldBackgroundColor,
      highlightColor: ColorConstants.secondaryScaffoldBacground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 300.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                color: ColorConstants.mainScaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r)),
              )),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.smallHeightSizedBox,
                loadingContainer(250),
                AppSizes.smallHeightSizedBox,
                loadingContainer(150),
                AppSizes.smallHeightSizedBox,
                loadingContainer(double.infinity),
                AppSizes.smallHeightSizedBox,
                loadingContainer(150),
                AppSizes.smallHeightSizedBox,
                SizedBox(
                  width: 500.w,
                  height: 60.h,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Container(
                            width: 100.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color:
                                    ColorConstants.mainScaffoldBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))));
                      }),
                      separatorBuilder: (BuildContext context, int index) {
                        return AppSizes.smallWidthSizedBox;
                      },
                      itemCount: 3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container loadingContainer(double w) {
    return Container(
        width: w.w,
        height: 35.h,
        decoration: BoxDecoration(
            color: ColorConstants.mainScaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10.r))));
  }
}
