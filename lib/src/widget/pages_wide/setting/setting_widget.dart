import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:ecommerce/src/widget/pages_wide/setting/deleteaccount_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constant/app_const.dart';
import '../../../model/button_model.dart';
import '../../../repository/user_repository/user_repository.dart';

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
          title: 'About',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
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
              flex: 6,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
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
              ))
        ],
      ),
    );
  }
}
