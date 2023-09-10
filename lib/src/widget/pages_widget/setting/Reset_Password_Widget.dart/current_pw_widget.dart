import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../View/setting/Reset_Password_Screens/reset_pw_screen.dart';
import '../../../../constant/app_const.dart';
import '../../../../getx/reset_pw_controller.dart';
import '../../../../model/login_model.dart';
import '../../../Text_Widget/form_text.dart';
import '../../../custom_Widget.dart/button_widget.dart';
import '../../../custom_Widget.dart/form_widget.dart';

class CurrentPasswordWidget extends StatefulWidget {
  const CurrentPasswordWidget({Key? key}) : super(key: key);

  @override
  State<CurrentPasswordWidget> createState() => _CurrentPasswordWidgetState();
}

class _CurrentPasswordWidgetState extends State<CurrentPasswordWidget> {
  final resetPwcontroller = Get.put(ResetPasswordController());
  void clear() {
    resetPwcontroller.oldPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: resetPwcontroller.currentFormkey,
          child: SizedBox(
            height: 550.h,
            width: 400.w,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(30.h.w),
              children: [
                mainText("Change Password"),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                blueText("Enter Your Current Password"),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                textFieldLabel(AppConst.password),
                FormWidget(
                    login: Login(
                        controller: resetPwcontroller.oldPassword,
                        hintText: AppConst.password,
                        icon: const Icon(Icons.password),
                        invisible: false,
                        validator: (password) =>
                            resetPwcontroller.validatePassword(password),
                        type: TextInputType.visiblePassword,
                        onChange: null,
                        inputFormat: null,
                        enable: true)),
                SizedBox(
                  height: AppConst.medium.h,
                ),
                ButtonWidget(
                    onTap: () {
                      resetPwcontroller.reAuth();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen()),
                      );
                    },
                    tilte: "Submit"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
