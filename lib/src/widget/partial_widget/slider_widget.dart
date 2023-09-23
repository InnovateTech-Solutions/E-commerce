import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/color.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({required this.item, Key? key}) : super(key: key);
  final List<Widget> item;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.item,
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            height: 250.0.h,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.item.map((item) {
            int index = widget.item.indexOf(item);
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
