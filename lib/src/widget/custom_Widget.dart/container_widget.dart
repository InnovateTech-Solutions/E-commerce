// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: imgName,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.r),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
