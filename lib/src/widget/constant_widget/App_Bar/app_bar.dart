import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';

firstAppBar() {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: ColorConstants.mainTextColor,
              ))
        ],
      )
    ],
  );
}

secondAppBar() {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: ColorConstants.secondaryScaffoldBacground,
    elevation: 0,
    centerTitle: true,
    title: Text(
      'Categorties',
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: ColorConstants.mainTextColor,
              ))
        ],
      )
    ],
  );
}

thirdAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.mainTextColor,
            ))
      ],
    ),
  );
}

productsAppBar(String title) {
  return AppBar(
    leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConstants.mainTextColor,
        )),
    backgroundColor: ColorConstants.secondaryScaffoldBacground,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.mainTextColor)),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: ColorConstants.mainTextColor,
              ))
        ],
      )
    ],
  );
}

profileAppBar() {
  return AppBar(
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorConstants.mainTextColor),
  );
}

cartAppbar() {
  return AppBar(
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorConstants.mainTextColor),
    title: mainVendorText('Confarmation page'),
  );
}

appointmentsAppBar() {
  return AppBar(
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorConstants.mainTextColor),
    title: mainVendorText('Select Time'),
  );
}

confirmAppBar(VendorModel vendorModel) {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
    elevation: 0,
    leading: IconButton(
        onPressed: () => {
              Get.to(VendorPage(vendor: vendorModel)),
            },
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConstants.mainTextColor,
        )),
    title: mainVendorText('Review and Confirm'),
  );
}
