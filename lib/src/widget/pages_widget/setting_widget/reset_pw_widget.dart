import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/reset_pw_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final resetPwcontroller = Get.put(ResetPasswordController());
  void clear() {
    resetPwcontroller.oldPassword.clear();
  }

  @override
  void dispose() {
    super.dispose();
    resetPwcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: resetPwcontroller.resetFormkey,
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
                blueText("Enter Your New Password"),
                SizedBox(
                  height: AppConst.medium.h,
                ),

                // New Password Field
                textFieldLabel("New Password"),
                FormWidget(
                    login: Login(
                        controller: resetPwcontroller.newPassword,
                        hintText: "New Password",
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

                // Confirm Password Field
                textFieldLabel("Confirm Password"),
                FormWidget(
                    login: Login(
                        controller: resetPwcontroller.confirmPassword,
                        hintText: "Confirm Password",
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
                      resetPwcontroller.changePassword();
                      clear();
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
