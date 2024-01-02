import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/search_model.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/partial_widget/dashboard_partial.dart/search_partial.dart';
import 'package:shimmer/shimmer.dart';

class DashboardTransition extends StatelessWidget {
  const DashboardTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorConstants.secondaryScaffoldBacground,
        highlightColor: ColorConstants.secondaryScaffoldBacground,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.all(18),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320.w,
                    child: SearchWidget(
                      search: SearchFormEntitiy(
                        hintText: "Search",
                        searchController: null,
                        icon: Icon(Icons.search, color: Colors.grey),
                        type: TextInputType.text,
                        onChange: (String) {},
                      ),
                    ),
                  ),
                  AppSizes.smallHeightSizedBox,
                  Container(
                    width: 250.w,
                    height: 186.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        color: ColorConstants.mainTextColor),
                  ),
                  AppSizes.largeHeightSizedBox,
                  AppSizes.smallHeightSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            color: Colors.black),
                      ),
                      Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            color: Colors.black),
                      ),
                    ],
                  ),
                  AppSizes.smallHeightSizedBox,
                  Center(
                    child: Container(
                      width: 350.w,
                      height: 100.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 85.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.r)),
                                  color: Colors.black),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return AppSizes.mediumWidthSizedBox;
                          },
                          itemCount: 3),
                    ),
                  ),
                  AppSizes.smallHeightSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            color: Colors.black),
                      ),
                      Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.r)),
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
