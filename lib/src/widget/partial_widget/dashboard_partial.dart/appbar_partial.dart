import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/getx/dashboard_controller.dart';

import '../../../constant/color.dart';

final controller = Get.put(DashboardController());

currentLocation() {
  return Container(
    height: 20.h,
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      color: ColorConstants.mainScaffoldBackgroundColor,
    ),
    child: DropdownButton<String>(
      isExpanded: true,
      value: controller.selectedItem.value == ""
          ? null
          : controller.selectedItem.value,
      onChanged: (newValue) {
        controller.upDateSelectedItem(newValue.toString());
      },
      underline: Container(),
      items: controller.location.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
