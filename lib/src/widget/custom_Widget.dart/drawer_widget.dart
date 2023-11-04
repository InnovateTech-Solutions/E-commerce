import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/profile_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/drawer_button.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class DrawerWidget extends StatelessWidget {
  final userController = Get.put(UserRepository());
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    final usercontroller = Get.put(UserController());
    return FutureBuilder(
        future: controller.getUserData(),
        builder: ((context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;
              final userName = TextEditingController(text: userData.name);
              return Padding(
                padding: EdgeInsets.only(left: 18.0.w),
                child: Column(
                  children: [
                    AppSizes.largeHeightSizedBox,
                    userController.getUserImageUrl(),
                    AppSizes.smallHeightSizedBox,
                    blueText(userName.text),
                    SizedBox(
                      height: AppConst.smallSize,
                    ),
                    divder(115.w, 0, 0),
                    AppSizes.mediumWidthSizedBox,
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: AppConst.drawer.length,
                          itemBuilder: ((context, index) {
                            return drawerWidget(AppConst.drawer[index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: AppConst.medium.h,
                            );
                          },
                        ),
                      ),
                    ),
                    divder(20.w, 0, 0),
                    AppSizes.smallHeightSizedBox,
                    drawerWidget(AppDrawerButton(
                        title: 'Support And Help',
                        icon: Icon(
                          Icons.support,
                          color: ColorConstants.mainTextColor,
                        ),
                        onTap: () {})),
                    SizedBox(
                      height: AppConst.medium,
                    ),
                    drawerWidget(
                      AppDrawerButton(
                        title: 'Logout',
                        icon: Icon(
                          Icons.logout,
                          color: ColorConstants.mainTextColor,
                        ),
                        onTap: () => {
                          AuthenticationRepository().logout(),
                          usercontroller.clearUserInfo()
                        },
                      ),
                    ),
                    AppSizes.mediumHeightSizedBox
                  ],
                ),
              );
            } else if (snapShot.hasError) {
              return Center(child: Text(snapShot.error.toString()));
            } else {
              return const Text("somthing went wrong");
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
