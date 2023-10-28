import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/categories_page.dart';
import 'package:profile_part/src/View/NavBar_pages/dashborad_page.dart';
import 'package:profile_part/src/View/NavBar_pages/map_page.dart';
import 'package:profile_part/src/View/setting/profile_page.dart';
import 'package:profile_part/src/View/setting/setting_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/button_model.dart';
import 'package:profile_part/src/model/drawer_button.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';

class AppConst {
  AppConst._();
  static bool passwordVisible = false;
  //size const
  static double smallSize = 15;
  static double medium = 35;
  static double largeSize = 45;
  // String const
  static String login = "LOGIN";
  static String signUp = "SIGN UP";
  static String email = "Email";
  static String password = "Password";
  static String username = "User Name";
  static String phoneNumber = "Phone Number";
  static String verificationOTP = "VERIFICATION CODE";
  //Divider
  static final pageDivider = Divider(
    indent: 20.0,
    endIndent: 10.0,
    thickness: 1,
    color: ColorConstants.textFiledmColor,
  );
  //List of profile widgets

  static List<Button> profileList = [
    Button(
        title: 'My Appointments',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () => null),
    Button(
        title: 'Setting',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () =>
            Get.to(const SettingPage(), transition: Transition.rightToLeft)),
    Button(
        title: 'About',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () {}),
    Button(
      title: 'Logout',
      icon: SvgPicture.asset(
        'assets/arrow.svg',
        matchTextDirection: true,
        width: 15.w,
        height: 15.h,
      ),
      onTap: () => {
        AuthenticationRepository().logout(),
      },
    ),
  ];

  // Drawer List
  static List<AppDrawerButton> drawer = [
    AppDrawerButton(
        title: 'Home',
        icon: Icon(
          Icons.home_outlined,
          color: ColorConstants.mainTextColor,
        ),
        onTap: () =>
            Get.to(const DashBoard(), transition: Transition.rightToLeft)),
    AppDrawerButton(
        title: 'Categoris',
        icon: Icon(
          Icons.category_outlined,
          color: ColorConstants.mainTextColor,
        ),
        onTap: () {
          Get.to(const CategoriesPage(),
              transition: Transition.rightToLeftWithFade);
        }),
    AppDrawerButton(
        title: 'Location',
        icon: Icon(
          Icons.location_on_outlined,
          color: ColorConstants.mainTextColor,
        ),
        onTap: () {
          Get.to(const MapPage(), transition: Transition.rightToLeft);
        }),
    AppDrawerButton(
        title: 'My Appointments',
        icon: Icon(
          Icons.access_time_outlined,
          color: ColorConstants.mainTextColor,
        ),
        onTap: () {}),
    AppDrawerButton(
        title: 'Profile',
        icon: Icon(
          Icons.person_2_outlined,
          color: ColorConstants.mainTextColor,
        ),
        onTap: () {
          Get.to(const ProfilePage(), transition: Transition.rightToLeft);
        }),
  ];
  //setting List
  static List<String> timeList = [
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM',
  ];
}
