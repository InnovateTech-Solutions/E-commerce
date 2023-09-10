import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_const.dart';
import '../../../constant/color.dart';
import '../../../repository/service_repository/service_data.dart';
import '../../custom_Widget.dart/container_widget.dart';
import '../../partial_widget/seemore_widget.dart';
import '../../partial_widget/slider_widget.dart';

class DashBoradWidget extends StatefulWidget {
  const DashBoradWidget({Key? key}) : super(key: key);

  @override
  State<DashBoradWidget> createState() => _DashBoradWidgetState();
}

class _DashBoradWidgetState extends State<DashBoradWidget> {
  late Future<List<Map<String, dynamic>>> dataFuture;
  final firebaseservice = Get.put(FirebaseService());

  @override
  void initState() {
    super.initState();
    dataFuture = firebaseservice.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataFuture,
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snpshot.hasError) {
            return Text('Erorr${snpshot.error}');
          } else {
            List<Map<String, dynamic>> data = snpshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SliderWidget(),
                  Container(
                    height: 500.h,
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
                              itemCount: data.length,
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
                                        imgName: data[index]['image'],
                                        onTap: () {},
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 140.h, left: 20.w),
                                        child: Text(data[index]['Title'],
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants
                                                        .mainScaffoldBackgroundColor))),
                                      )
                                    ],
                                  ),
                                );
                              })),
                        ),
                        seeMore()
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
