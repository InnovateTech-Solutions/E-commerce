import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_io.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/slider_controller.dart';
import 'package:profile_part/src/model/servicw_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';
import 'package:profile_part/src/widget/partial_widget/seemore_widget.dart';
import 'package:profile_part/src/widget/partial_widget/slider_widget.dart';

class DashBoradWidget extends StatefulWidget {
  const DashBoradWidget({Key? key}) : super(key: key);

  @override
  State<DashBoradWidget> createState() => _DashBoradWidgetState();
}

class _DashBoradWidgetState extends State<DashBoradWidget> {
  final firebaseservice = Get.put(FirebaseService());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseservice.fetchData(),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.done) {
            if (snpshot.hasData) {
              List<Map<String, dynamic>> servicesData = snpshot.data!;
              return Column(
                children: [
                  const SliderWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 450.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            color: ColorConstants.mainScaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppConst.smallSize,
                            ),
                            SizedBox(
                              height: 340.h,
                              child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: servicesData.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 2,
                                  ),
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      width: 150.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.r))),
                                      child: Stack(
                                        children: [
                                          DashboradContainer(
                                            imgName: servicesData[index]
                                                ['image'],
                                            onTap: () {},
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 140.h, left: 20.w),
                                            child: Text(
                                                servicesData[index]['Title'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorConstants
                                                            .mainScaffoldBackgroundColor))),
                                          )
                                        ],
                                      ),
                                    );
                                  })),
                            ),
                            SeeMore(
                              onTap: () => null,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snpshot.hasError) {
              return Text('Erorr${snpshot.error}');
            } else {
              return const Text("somthing went wrong");
            }
          } else if (snpshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text("somthing went wrong");
          }
        });
  }
}
