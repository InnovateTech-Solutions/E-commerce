import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/login_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/constant_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class DeleteUserAccountWidget extends StatelessWidget {
  DeleteUserAccountWidget({super.key});
  final logincontroller = Get.put(LoginController());
  final autuhcontroller = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: AppConst.largeSize.h,
            ),
            mainText("Delete my account"),
            divder(150.w, 0, 0),
            SizedBox(
              height: AppConst.largeSize.h,
            ),
            textFieldLabel(AppConst.email),
            FormWidget(
                login: Login(
                    enable: true,
                    controller: logincontroller.email,
                    hintText: AppConst.email,
                    icon: const Icon(Icons.email),
                    invisible: false,
                    validator: (email) => logincontroller.validateEmail(email),
                    type: TextInputType.emailAddress,
                    onChange: null,
                    inputFormat: null)),
            SizedBox(
              height: AppConst.smallSize.h,
            ),
            textFieldLabel(AppConst.password),
            FormWidget(
                login: Login(
                    enable: true,
                    controller: logincontroller.password,
                    hintText: AppConst.password,
                    icon: const Icon(Icons.lock),
                    invisible: true,
                    validator: (password) =>
                        logincontroller.vaildatePassword(password),
                    type: TextInputType.visiblePassword,
                    onChange: null,
                    inputFormat: null)),
            SizedBox(
              height: AppConst.smallSize.h,
            ),
            ButtonWidget(
              onTap: () {
                autuhcontroller.deleteUserAccount(
                    logincontroller.email.text, logincontroller.password.text);
              },
              tilte: 'Delete account',
            ),
          ],
        ),
      )),
    );
  }
}
