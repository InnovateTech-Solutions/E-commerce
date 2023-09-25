import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/setting/profile_page.dart';
import '../../constant/app_const.dart';
import '../../constant/color.dart';
import '../../getx/profile_controller.dart';
import '../../model/button_model.dart';
import '../../model/user_model.dart';
import '../../repository/user_repository/user_repository.dart';
import '../Text_Widget/form_text.dart';
import '../constant_widget/constant_widget.dart';

class DrawerWidget extends StatelessWidget {
  final userController = Get.put(UserRepository());
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    List<DraweButton> drawer = [
      DraweButton(
          title: 'Home',
          icon: Icon(
            Icons.home_outlined,
            color: ColorConstants.mainTextColor,
          ),
          onTap: () {
            Get.to("");
          }),
      DraweButton(
          title: 'Categoris',
          icon: Icon(
            Icons.category_outlined,
            color: ColorConstants.mainTextColor,
          ),
          onTap: () {}),
      DraweButton(
          title: 'Location',
          icon: Icon(
            Icons.location_on_outlined,
            color: ColorConstants.mainTextColor,
          ),
          onTap: () {}),
      DraweButton(
          title: 'My Appointments',
          icon: Icon(
            Icons.access_time_outlined,
            color: ColorConstants.mainTextColor,
          ),
          onTap: () {}),
      DraweButton(
          title: 'Profile',
          icon: Icon(
            Icons.person_2_outlined,
            color: ColorConstants.mainTextColor,
          ),
          onTap: () {
            Get.to(const ProfilePage());
          }),
    ];
    return FutureBuilder(
        future: controller.getUserData(),
        builder: ((context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;
              final userName = TextEditingController(text: userData.name);
              final image = TextEditingController(text: userData.imageUrl);
              return Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConst.medium.h,
                    ),
                    userController.getUserImageUrl(),
                    SizedBox(
                      height: AppConst.smallSize,
                    ),
                    blueText(userName.text),
                    SizedBox(
                      height: AppConst.smallSize,
                    ),
                    divder(115.w, 0, 0),
                    SizedBox(
                      width: AppConst.medium,
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.separated(
                          itemCount: drawer.length,
                          itemBuilder: ((context, index) {
                            return drawerWidget(drawer[index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: AppConst.medium,
                            );
                          },
                        ),
                      ),
                    ),
                    divder(2000.w, 0, 0),
                    drawerWidget(DraweButton(
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
                      DraweButton(
                          title: 'Logout',
                          icon: Icon(
                            Icons.logout,
                            color: ColorConstants.mainTextColor,
                          ),
                          onTap: () {}),
                    ),
                    SizedBox(
                      height: AppConst.smallSize,
                    )
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
