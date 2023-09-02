import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';
import 'package:profile_part/src/widget/partial_widget/slider_widget.dart';

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
                    height: 400.h,
                    width: double.infinity,
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
                          height: 300.h,
                          child: GridView.builder(
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 2,
                              ),
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 200.w,
                                  height: 128.h,
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
                                                        .mainTextColor))),
                                      )
                                    ],
                                  ),
                                );
                              })),
                        ),
                        /*   Container(
                          width: 200.w,
                          height: 128.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.r))),
                          child: Stack(
                            children: [
                              DashboradContainer(
                                imgName:
                                    'https://www.bostonmagazine.com/wp-content/uploads/sites/2/2019/01/aer-nail-bar.jpg',
                                onTap: () {},
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 100.h, left: 20.w),
                                child: Text('nail saloon',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                ColorConstants.mainTextColor))),
                              )
                            ],
                          ),
                        )
                     */
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
