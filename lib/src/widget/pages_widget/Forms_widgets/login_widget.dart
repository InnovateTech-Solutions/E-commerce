import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/constant_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/login_icon.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: controller.formkey,
          child: SizedBox(
            height: 550.h,
            width: 400.w,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(30.h.w),
              children: [
                SvgPicture.asset(
                  "assets/Logo.svg",
                  width: 114.w,
                  height: 57.h,
                ),
                constDivider(),
                mainText(AppConst.login),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                textFieldLabel(AppConst.email),
                FormWidget(
                    login: Login(
                        controller: controller.email,
                        hintText: AppConst.email,
                        icon: const Icon(Icons.email),
                        invisible: false,
                        validator: (email) => controller.validateEmail(email),
                        type: TextInputType.emailAddress,
                        onChange: null,
                        inputFormat: null)),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                textFieldLabel(AppConst.password),
                FormWidget(
                    login: Login(
                        controller: controller.password,
                        hintText: AppConst.password,
                        icon: const Icon(Icons.lock),
                        invisible: true,
                        validator: (password) =>
                            controller.vaildatePassword(password),
                        type: TextInputType.visiblePassword,
                        onChange: null,
                        inputFormat: null)),
                forgetPasswordText(context),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                ButtonWidget(
                    onTap: () => controller.onLogin(), tilte: AppConst.login),
                dontHaveAccountRow(),
              ],
            ),
          ),
        ),
        const LoginIcon()
      ],
    );
  }
}
