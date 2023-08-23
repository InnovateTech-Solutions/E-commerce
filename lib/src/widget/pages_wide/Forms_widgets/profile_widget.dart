import 'package:ecommerce/src/View/setting/edit_page.dart';
import 'package:ecommerce/src/View/setting/setting_page.dart';
import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../model/button_model.dart';
import '../../../repository/authentication/authentication_repository.dart';
import '../../../repository/user_repository/user_repository.dart';

class ProfileWidget extends StatelessWidget {
  final controller = Get.put(UserRepository());

  ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Button> profile = [
      Button(
          title: 'My Appointments',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Payment Method',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Setting',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const SettingPage())),
      Button(
        title: 'Logout',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () => AuthenticationRepository().logout(),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/Profilepic.svg",
                  width: 100.w,
                  height: 100.h,
                ),
                SizedBox(
                  height: AppConst.smallSize,
                ),
                blueText("username"),
                SizedBox(
                  height: AppConst.smallSize,
                ),
                divder(115.w, 0, 0),
                Center(
                    child: textButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()));
                }, "View Profile")),
              ],
            ),
          ),
          Expanded(
              flex: 5,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: profile.length,
                  itemBuilder: ((context, index) {
                    return profileWidget(profile[index]);
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: AppConst.medium,
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
