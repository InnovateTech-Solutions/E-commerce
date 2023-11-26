import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/register_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/login_external.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

import '../../../constant/color.dart';

class FirstRegisterWidget extends StatefulWidget {
  const FirstRegisterWidget({Key? key}) : super(key: key);

  @override
  State<FirstRegisterWidget> createState() => _FirstRegisterWidgetState();
}

class _FirstRegisterWidgetState extends State<FirstRegisterWidget> {
  final controller = Get.put(RegisterController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      super.dispose();
      controller.dispose();
    }

    void clearText() {
      controller.phoneNumber.clear();
      controller.age.clear();
      controller.gander.clear();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Center(
            child: Form(
                key: controller.firstFormkey,
                child: SizedBox(
                  height: 520.h,
                  width: 320.w,
                  child: ListView(
                    children: [
                      mainText("Register Your Account"),
                      AppSizes.smallHeightSizedBox,
                      textFieldLabel(AppConst.email),
                      FormWidget(
                        login: Login(
                          enableText: false,
                          controller: controller.email,
                          hintText: AppConst.email,
                          icon: const Icon(Icons.email),
                          invisible: false,
                          validator: (email) => controller.validateEmail(email),
                          type: TextInputType.emailAddress,
                          onChange: null,
                          inputFormat: null,
                          onTap: () {},
                        ),
                        color: ColorConstants.mainScaffoldBackgroundColor,
                      ),
                      AppSizes.smallHeightSizedBox,
                      textFieldLabel(AppConst.username),
                      FormWidget(
                        login: Login(
                          enableText: false,
                          controller: controller.userName,
                          hintText: AppConst.username,
                          icon: const Icon(Icons.abc),
                          invisible: false,
                          validator: (email) =>
                              controller.vaildateUserName(email),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          onTap: () {},
                        ),
                        color: ColorConstants.mainScaffoldBackgroundColor,
                      ),
                      AppSizes.smallHeightSizedBox,
                      textFieldLabel(AppConst.password),
                      FormWidget(
                        login: Login(
                          enableText: false,
                          controller: controller.password,
                          hintText: AppConst.password,
                          icon: const Icon(Icons.password),
                          invisible: true,
                          validator: (email) =>
                              controller.vaildatePassword(email),
                          type: TextInputType.visiblePassword,
                          onChange: null,
                          inputFormat: null,
                          onTap: () {},
                        ),
                        color: ColorConstants.mainScaffoldBackgroundColor,
                      ),
                      AppSizes.smallHeightSizedBox,
                      textFieldLabel(AppConst.confirmPassword),
                      FormWidget(
                        login: Login(
                          enableText: false,
                          controller: controller.confirmPassword,
                          hintText: AppConst.confirmPassword,
                          icon: const Icon(Icons.password),
                          invisible: true,
                          validator: (password) =>
                              controller.validConfirmPassword(password),
                          type: TextInputType.visiblePassword,
                          onChange: null,
                          inputFormat: null,
                          onTap: () {},
                        ),
                        color: ColorConstants.mainScaffoldBackgroundColor,
                      ),
                      AppSizes.mediumHeightSizedBox,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.r,
                                blurRadius: 10.r,
                                offset: const Offset(0, 2)),
                          ],
                        ),
                        child: onLoginContainer(
                            onTap: () => {
                                  controller.secondScreenNavigate(),
                                  userController.saveUserInfo(UserModel(
                                      email: controller.email.text.trim(),
                                      name: controller.userName.text.trim(),
                                      password: controller.password.text.trim(),
                                      phone: controller.phoneNumber.text.trim(),
                                      imageUrl: '',
                                      age: controller.age.text.trim(),
                                      gander: controller.gander.text.trim()))
                                },
                            title: "Next"),
                      )
                    ],
                  ),
                )),
          ),
          LoginExternal(),
        ],
      ),
    );
  }
}
