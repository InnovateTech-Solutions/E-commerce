import 'package:ecommerce/src/View/setting/edit_page.dart';
import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/constant/profile_list.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../repository/user_repository/user_repository.dart';

class ProfileWidget extends StatelessWidget {
  final controller = Get.put(UserRepository());

  ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      buildDialog(context);
                    },
                    child: Text("language")),
                SvgPicture.asset(
                  "assets/Profilepic.svg",
                  width: 100.w,
                  height: 100.h,
                ),
                blueText("username"),
                divder(150.w, 0, 0),
                SizedBox(
                  height: AppConst.smallSize,
                ),
                Center(
                    child: textButton(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()));
                }, "View Profile")),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: ProfileContent.profile.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return ProfileContent.profile[index];
                }),
          ),
        ],
      ),
    );
  }
}
