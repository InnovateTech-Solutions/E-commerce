// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({required this.imgName, required this.onTap, Key? key})
      : super(key: key);
  final String imgName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0.r),
                image: DecorationImage(
                    image: NetworkImage(imgName), fit: BoxFit.cover),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(14.r))),
          ),
        ],
      ),
    );
  }
}
