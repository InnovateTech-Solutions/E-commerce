import 'package:ecommerce/src/model/profile_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileContent {
  static List<Profile> profile = [
    Profile(
        txt: "Appointments",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          width: 15.w,
          height: 15.h,
        ),
        destinationRoute: ""),
    Profile(
        txt: "Payment Method",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          width: 15.w,
          height: 15.h,
        ),
        destinationRoute: ""),
    Profile(
        txt: "Sitting",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          width: 15.w,
          height: 15.h,
        ),
        destinationRoute: ""),
    Profile(
        txt: "Language",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          width: 15.w,
          height: 15.h,
        ),
        destinationRoute: ""),
    Profile(
        txt: "Logout",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          width: 15.w,
          height: 15.h,
        ),
        destinationRoute: ""),
  ];
}
