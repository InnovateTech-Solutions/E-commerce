import 'package:ecommerce/src/constant/profile_list.dart';
import 'package:ecommerce/src/model/profile_model.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: ProfileContent.profile.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ProfileButton(ProfileContent.profile[index]);
        });
  }

  InkWell ProfileButton(Profile button) {
    return InkWell(
      onTap: () {
        Get.toNamed(button.destinationRoute);
      },
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          secText(button.txt),
          SizedBox(
            width: 150.w,
          ),
          button.icon
        ],
      ),
    );
  }
}
