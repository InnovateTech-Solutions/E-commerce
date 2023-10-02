import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/setting/update_profile.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

import '../../../getx/profile_controller.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../constant_widget/const_widget/constant_widget.dart';

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
        const Duration(seconds: 1),
        () => controllerr.getUserData(),
      ),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            UserModel userData = snapShot.data as UserModel;
            final userName = TextEditingController(text: userData.name);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        userController.getUserImageUrl(),
                        AppSizes.smallHeightSizedBox,
                        blueText(userName.text),
                        AppSizes.smallHeightSizedBox,
                        divder(115.w, 0, 0),
                        textButton(
                            () => Get.to(const UpdateProfile(),
                                transition: Transition.upToDown),
                            "View Profile"),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: AppConst.profileList.length,
                          itemBuilder: ((context, index) {
                            return profileWidget(AppConst.profileList[index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return AppSizes.mediumHeightSizedBox;
                          },
                        ),
                      )),
                ],
              ),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text('Error${snapShot.error}'));
          } else {
            return const Text("something went wrong");
          }
        } else if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return const Text("somthing went wrong");
        }
      },
    );
  }
}
