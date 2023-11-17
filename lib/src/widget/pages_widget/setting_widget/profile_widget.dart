import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/setting/update_profile.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/profile_controller.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/transition/profile_transition.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/pastlogin_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/pages_widget/Forms_widgets/pastlogin_widget.dart';

import '../../../constant/color.dart';
import '../../../model/login_model.dart';
import '../../../repository/authentication/authentication_repository.dart';
import '../../custom_Widget.dart/form_widget.dart';
import '../../partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final userController = Get.put(UserRepository());
  final _authcontroller = Get.put(AuthenticationRepository());

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
                      width: 350.w,
                      child: ListView.separated(
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
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainPastLoginText(AppConst.pastlogin),
                    AppSizes.smallHeightSizedBox,
                    secondaryPastLoginText(AppConst.pastloginText),
                    AppSizes.smallHeightSizedBox,
                    continueContainer(
                        title: AppConst.googleContainerText,
                        imgname: AppConst.googleimg,
                        callback: _authcontroller.signInWithGoogle),
                    AppSizes.smallHeightSizedBox,
                    continueContainer(
                        title: AppConst.appleCotanierText,
                        imgname: AppConst.appleimg,
                        callback: () => _authcontroller.signInWithGoogle),
                    AppSizes.smallHeightSizedBox,
                    AppConst.pageDivider,
                    AppSizes.smallHeightSizedBox,
                    Form(
                        key: controller.formkey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2.r,
                                      blurRadius: 3.r,
                                      offset: const Offset(0, 2)),
                                ],
                              ),
                              child: FormWidget(
                                login: Login(
                                  enableText: false,
                                  controller: controller.email,
                                  hintText: AppConst.email,
                                  icon: const Icon(Icons.email),
                                  invisible: false,
                                  validator: (email) =>
                                      controller.validateEmail(email),
                                  type: TextInputType.emailAddress,
                                  onChange: null,
                                  inputFormat: null,
                                ),
                                color:
                                    ColorConstants.mainScaffoldBackgroundColor,
                              ),
                            ),
                            AppSizes.smallHeightSizedBox,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2.r,
                                      blurRadius: 3.r,
                                      offset: const Offset(0, 2)),
                                ],
                              ),
                              child: FormWidget(
                                login: Login(
                                  enableText: false,
                                  controller: controller.password,
                                  hintText: AppConst.password,
                                  icon: const Icon(Icons.lock),
                                  invisible: false,
                                  validator: (password) =>
                                      controller.vaildatePassword(password),
                                  type: TextInputType.visiblePassword,
                                  onChange: null,
                                  inputFormat: null,
                                ),
                                color:
                                    ColorConstants.mainScaffoldBackgroundColor,
                              ),
                            ),
                            AppSizes.mediumHeightSizedBox,
                            onLoginContainer(
                                title: AppConst.login, onTap: () => {})
                          ],
                        )),
                  ],
                ),
              ),
            );
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
