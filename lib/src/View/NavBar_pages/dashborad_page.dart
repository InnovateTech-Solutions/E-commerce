import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/Forms/update_profile.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/first_appbar.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/carousel_widget.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/dashborad_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: firstAppBar(),
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        body: const DashBoradWidget(),
      ),
    );
  }

  Column buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () => Get.to(const UpdateProfile()),
              child: const Text('update profile')),
        ),
        ElevatedButton(
            onPressed: () => AuthenticationRepository().logout(),
            child: const Text('log out')),
      ],
    );
  }
}

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _currentIndex = 0;

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

    return Scaffold(
      backgroundColor: ColorConstants.secondaryScaffoldBacground,
      body: Column(
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
                margin:
                    EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.0.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? ColorConstants.mainTextColor
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
