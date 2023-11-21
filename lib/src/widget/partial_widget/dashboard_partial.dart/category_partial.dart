// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {required this.imgName, required this.onTap, Key? key})
      : super(key: key);
  final String imgName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.r,
                blurRadius: 3.r,
                offset: const Offset(0, 2)),
          ],
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: SvgPicture.network(imgName),
      ),
    );
  }
}
