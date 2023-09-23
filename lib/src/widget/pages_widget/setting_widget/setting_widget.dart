import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/setting/deleteaccount_widget.dart';
import 'package:profile_part/src/View/setting/reset_pw_screen.dart';

import '../../../constant/app_const.dart';
import '../../../model/button_model.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../constant_widget/constant_widget.dart';

class SettingWidget extends StatelessWidget {
  final controller = Get.put(UserRepository());

  SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Button> setting = [
      Button(
          title: 'Customer Support',
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
          onTap: () => Get.to(DeleteUserAccountWidget())),
      Button(
          title: 'Change Password',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const ResetPasswordScreen())),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: AppConst.medium.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: mainText("Setting")),
                divder(150, 0, 0),
                SizedBox(
                  height: AppConst.largeSize,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: AppConst.smallSize,
                    ),
                    textFieldLabel("Notifications"),
                    const Spacer(),
                    switchButton(true),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: setting.length,
                    itemBuilder: ((context, index) {
                      return profileWidget(setting[index]);
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: AppConst.medium,
                      );
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
