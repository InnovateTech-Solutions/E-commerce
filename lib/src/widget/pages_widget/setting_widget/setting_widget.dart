import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/setting/delete_account.dart';
import 'package:profile_part/src/View/setting/reset_pw_screen.dart';
import 'package:profile_part/src/model/button_model.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/partial_widget/setting_partial/setting.dart';

class SettingWidget extends StatelessWidget {
  final controller = Get.put(UserRepository());
  SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Button> setting = [
      Button(
          title: 'Notification',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Language',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => buildDialog(context)),
      Button(
          title: 'Delete my account',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const DeleteAccountPage(),
              transition: Transition.rightToLeft)),
      Button(
          title: 'Change Password',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const ResetPasswordScreen(),
              transition: Transition.rightToLeft)),
    ];
    return FutureBuilder(
      future: Future.delayed(
        const Duration(milliseconds: 500),
      ),
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              settingColumn(),
              AppSizes.mediumHeightSizedBox,
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: setting.length,
                    itemBuilder: ((context, index) {
                      return profileWidget(setting[index]);
                    }),
                    separatorBuilder: (BuildContext context, int index) =>
                        AppSizes.mediumHeightSizedBox,
                  ),
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
