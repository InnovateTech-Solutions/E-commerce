import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({required this.imgName, required this.onTap, Key? key})
      : super(key: key);
  final String imgName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.r),
            image: DecorationImage(
                image: NetworkImage(imgName), fit: BoxFit.cover),
          )),
    );
  }
}
