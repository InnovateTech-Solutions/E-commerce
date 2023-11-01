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
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final userController = Get.put(UserController());

    @override
    void dispose() {
      super.dispose();
      controller.dispose();
    }

    void clearText() {
      controller.email.clear();
      controller.password.clear();
      controller.phoneNumber.clear();
      controller.userName.clear();
    }

    return Form(
        key: controller.fromkey,
        child: SizedBox(
          height: 650.h,
          width: 400.w,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
            children: [
              AppSizes.largeHeightSizedBox,
              mainText(AppConst.signUp),
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
              )),
              AppSizes.smallHeightSizedBox,
              textFieldLabel(AppConst.username),
              FormWidget(
                  login: Login(
                enableText: false,
                controller: controller.userName,
                hintText: AppConst.username,
                icon: const Icon(Icons.abc),
                invisible: false,
                validator: (email) => controller.vaildateUserName(email),
                type: TextInputType.name,
                onChange: null,
                inputFormat: null,
              )),
              AppSizes.smallHeightSizedBox,
              textFieldLabel(AppConst.password),
              FormWidget(
                  login: Login(
                enableText: false,
                controller: controller.password,
                hintText: AppConst.password,
                icon: const Icon(Icons.password),
                invisible: true,
                validator: (email) => controller.vaildatePassword(email),
                type: TextInputType.visiblePassword,
                onChange: null,
                inputFormat: null,
              )),
              AppSizes.smallHeightSizedBox,
              textFieldLabel(AppConst.phoneNumber),
              FormWidget(
                  login: Login(
                enableText: false,
                controller: controller.phoneNumber,
                hintText: AppConst.phoneNumber,
                icon: const Icon(Icons.phone),
                invisible: false,
                validator: (email) => controller.vaildPhoneNumber(email),
                type: TextInputType.number,
                onChange: null,
                inputFormat: null,
              )),
              AppSizes.smallHeightSizedBox,
              ButtonWidget(
                  onTap: () => {
                        controller.onSignup(UserModel(
                            email: controller.email.text.trim(),
                            name: controller.userName.text.trim(),
                            password: controller.password.text.trim(),
                            phone: controller.phoneNumber.text.trim(),
                            imageUrl: '')),
                        dispose(),
                        clearText(),
                        userController.saveUserInfo(UserModel(
                            email: controller.email.text.trim(),
                            name: controller.userName.text.trim(),
                            password: controller.password.text.trim(),
                            phone: controller.phoneNumber.text.trim(),
                            imageUrl: ''))
                      },
                  tilte: AppConst.signUp)
            ],
          ),
        ));
  }
}