import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/nav_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/carousel_widget.dart';

class DashBoradWidget extends StatefulWidget {
  const DashBoradWidget({Key? key}) : super(key: key);

  @override
  State<DashBoradWidget> createState() => _DashBoradWidgetState();
}

class _DashBoradWidgetState extends State<DashBoradWidget> {
  int _currentIndex = 0;
  late Future<List<Map<String, dynamic>>> dataFuture;
  final firebaseservice = Get.put(FirebaseService());

  @override
  void initState() {
    super.initState();
    dataFuture = firebaseservice.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      CarouselWidget(
        imgName:
            "https://inventemr.com/cloud/storage/media/medical-firms/logos/Ram_Medical_Center_medical_bh_invent_its_bahrain_1626169335.jpg",
        onTap: () {},
      ),
      CarouselWidget(
        imgName:
            "https://www.bahrainyellow.com/img/bh/n/1494139747-97-smile-studios-dental-clinic.jpg",
        onTap: () {},
      ),
    ];
    return Column(
      children: [
        CarouselSlider(
          items: carouselItems,
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            height: 200.0.h,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.map((item) {
            int index = carouselItems.indexOf(item);
            return Container(
              width: 8.0.w,
              height: 8.0.h,
              margin: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.0.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? ColorConstants.mainTextColor
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                height: 290.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.mainScaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                child: ListView(
                  children: [
                    SizedBox(
                      height: AppConst.smallSize,
                    ),
                    headText('POPULAR SERVICES')
                  ],
                )))
      ],
    );
  }
}
