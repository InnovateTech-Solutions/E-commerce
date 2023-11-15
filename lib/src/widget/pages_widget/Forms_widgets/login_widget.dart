import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/login_external.dart';

import '../../../getx/login_Controller.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void clearText() {
    controller.email.clear();
    controller.password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: controller.formkey,
          child: SizedBox(
            height: 550,
            width: double.infinity,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              children: [
                SvgPicture.asset(
                  "assets/Logo.svg",
                  width: 114.w,
                  height: 57.h,
                ),
                constDivider(),
                mainText(AppConst.login),
                AppSizes.mediumHeightSizedBox,
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
                )),
                AppSizes.mediumHeightSizedBox,
                textFieldLabel(AppConst.password),
                FormWidget(
                    login: Login(
                  enableText: false,
                  controller: controller.password,
                  hintText: AppConst.password,
                  icon: const Icon(Icons.lock),
                  invisible: true,
                  validator: (password) =>
                      controller.vaildatePassword(password),
                  type: TextInputType.visiblePassword,
                  onChange: null,
                  inputFormat: null,
                )),
                forgetPasswordText(context),
                AppSizes.mediumHeightSizedBox,
                ButtonWidget(
                    onTap: () => {
                          controller.onLogin(),
                          dispose(),
                          clearText(),
                          UserRepository.instance
                              .getUserDetails(controller.email.text.trim()),
                          UserController.instance.logIn(),
                        },
                    title: AppConst.login),
                dontHaveAccountRow(),
              ],
            ),
          ),
        ),
        AppSizes.mediumHeightSizedBox,
        LoginExternal(),
      ],
    );
  }
}
