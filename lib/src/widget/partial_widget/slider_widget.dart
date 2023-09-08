import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      DashboradContainer(
        imgName:
            "https://inventemr.com/cloud/storage/media/medical-firms/logos/Ram_Medical_Center_medical_bh_invent_its_bahrain_1626169335.jpg",
        onTap: () {},
      ),
      DashboradContainer(
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
      ],
    );
  }
}
