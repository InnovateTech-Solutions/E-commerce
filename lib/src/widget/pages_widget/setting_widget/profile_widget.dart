import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/Forms/update_profile.dart';
import 'package:profile_part/src/View/setting/setting_page.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/map_controller.dart';
import '../../../getx/profile_controller.dart';
import '../../../model/button_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/authentication/authentication_repository.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../constant_widget/constant_widget.dart';

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
    final mapController = Get.put(MapController());
    List<Button> profile = [
      Button(
          title: 'My Appointments',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {
            mapController.determinePosition();
          }),
      Button(
          title: 'Payment Method',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Setting',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const SettingPage())),
      Button(
          title: 'About',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
        title: 'Logout',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () => AuthenticationRepository().logout(),
      ),
    ];
    return FutureBuilder(
      future: controllerr.getUserData(),
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
                        SizedBox(
                          height: AppConst.smallSize,
                        ),
                        blueText(userName.text),
                        SizedBox(
                          height: AppConst.smallSize,
                        ),
                        divder(115.w, 0, 0),
                        Center(
                            child: textButton(
                                () => Get.to(const UpdateProfile()),
                                "View Profile")),
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
                          itemCount: profile.length,
                          itemBuilder: ((context, index) {
                            return profileWidget(profile[index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: AppConst.medium,
                            );
                          },
                        ),
                      )),
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
      },
    );
  }
}
