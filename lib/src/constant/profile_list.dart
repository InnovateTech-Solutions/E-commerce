import 'package:ecommerce/src/model/profile_model.dart';
import 'package:ecommerce/src/widget/pages_wide/sitting/deleteaccount_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../repository/authentication/authentication_repository.dart';

class ProfileContent {
  static List<ProfileButton> profile = [
    ProfileButton(
        title: "My Appointments",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {
          Get.toNamed('/EditProfilePage');
        }),
    ProfileButton(
        title: "Payment Method",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {}),
    ProfileButton(
        title: "Sitting",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {}),
    ProfileButton(
        title: "Logout",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {
          AuthenticationRepository().logout();
        }),
  ];
}

class SittingContent {
  static List<ProfileButton> sitting = [
    ProfileButton(
      title: "Notification",
      onTap: () {},
      icon: SvgPicture.asset(
        "assets/arrow.svg",
        matchTextDirection: true,
        width: 15.w,
        height: 15.h,
      ),
    ),
    ProfileButton(
      title: "Customer Support",
      onTap: () {},
      icon: SvgPicture.asset(
        "assets/arrow.svg",
        matchTextDirection: true,
        width: 15.w,
        height: 15.h,
      ),
    ),
    ProfileButton(
        title: "Language",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {
          // buildDialog(context);
        }),
    ProfileButton(
      title: "Delete my ccount",
      onTap: () {
        Get.to(DeleteUserAccount());
      },
      icon: SvgPicture.asset(
        "assets/arrow.svg",
        matchTextDirection: true,
        width: 15.w,
        height: 15.h,
      ),
    ),
    ProfileButton(
      title: "About",
      onTap: () {},
      icon: SvgPicture.asset(
        "assets/arrow.svg",
        matchTextDirection: true,
        width: 15.w,
        height: 15.h,
      ),
    ),
    ProfileButton(
        title: "Logout",
        icon: SvgPicture.asset(
          "assets/arrow.svg",
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {
          AuthenticationRepository().logout();
        }),
  ];
}
