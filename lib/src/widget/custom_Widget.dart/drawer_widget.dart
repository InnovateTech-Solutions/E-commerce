import 'package:ecommerce/src/model/button_model.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constant/app_const.dart';
import '../../getx/profile_controller.dart';
import '../../model/user_model.dart';
import '../../repository/user_repository/user_repository.dart';
import '../Text_Widget/form_text.dart';

class DrawerWidget extends StatelessWidget {
  final userController = Get.put(UserRepository());
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    List<Button> drawer = [
      Button(
          title: 'Home',
          icon: SvgPicture.asset(
            'assets/home.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'Categoris',
          icon: SvgPicture.asset(
            'assets/cat.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'Location',
          icon: SvgPicture.asset(
            'assets/location.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'My Appointments',
          icon: SvgPicture.asset(
            'assets/appointment.svg',
            matchTextDirection: true,
            width: 25.w,
            height: 25.h,
          ),
          onTap: () {}),
      Button(
          title: 'Profile',
          icon: SvgPicture.asset(
            'assets/profile.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
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
                    drawerWidget(Button(
                        title: 'Support And Help',
                        icon: SvgPicture.asset(
                          'assets/support.svg',
                          matchTextDirection: true,
                          width: 20.w,
                          height: 20.h,
                        ),
                        onTap: () {})),
                    SizedBox(
                      height: AppConst.medium,
                    ),
                    drawerWidget(Button(
                        title: 'Logout',
                        icon: SvgPicture.asset(
                          'assets/logout.svg',
                          matchTextDirection: true,
                          width: 20.w,
                          height: 20.h,
                        ),
                        onTap: () {})),
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
