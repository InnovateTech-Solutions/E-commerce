import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

searchDashboard() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.h),
    child: SizedBox(
      width: 350.w,
      height: 50.h,
      child: TextField(
          decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      )),
    ),
  );
}
