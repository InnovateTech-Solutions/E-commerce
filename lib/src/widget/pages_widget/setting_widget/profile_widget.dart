import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/Forms/pastlogin_page.dart';
import 'package:profile_part/src/View/setting/update_profile.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/profile_controller.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/transition/profile_transition.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final userController = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    final controllerr = Get.put(ProfileController());
    final userController = Get.put(UserRepository());
    return FutureBuilder(
      future: Future.delayed(
        const Duration(milliseconds: 500),
        () => controllerr.getUserData(),
      ),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            UserModel userData = snapShot.data as UserModel;
            final userName = TextEditingController(text: userData.name);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: [
                        userController.getUserImageUrl(),
                        AppSizes.smallHeightSizedBox,
                        blueText(userName.text),
                        AppSizes.smallHeightSizedBox,
                        divder(115.w, 0, 0),
                        textButton(
                            () => Get.to(const UpdateProfile(),
                                transition: Transition.fade),
                            "View Profile"),
                      ],
                    ),
                    AppSizes.smallHeightSizedBox,
                    SizedBox(
                      height: 300.h,
                      width: double.infinity.w,
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: AppConst.profileList.length,
                        itemBuilder: ((context, index) {
                          return profileWidget(AppConst.profileList[index]);
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return AppSizes.mediumHeightSizedBox;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text('Error${snapShot.error}'));
          } else {
            return PastLoginPage();
          }
        } else if (snapShot.connectionState == ConnectionState.waiting) {
          return ProfileTransition();
        } else {
          return const Text("somthing went wrong");
        }
      },
    );
  }
}
