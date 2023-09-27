import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/login_Controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class DeleteAccountWidget extends StatefulWidget {
  const DeleteAccountWidget({Key? key}) : super(key: key);

  @override
  State<DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<DeleteAccountWidget> {
  @override
  Widget build(BuildContext context) {
    final logincontroller = Get.put(LoginController());
    final autuhcontroller = Get.put(AuthenticationRepository());
    @override
    void dispose() {
      super.dispose();
      logincontroller.dispose();
      autuhcontroller.dispose();
    }

    void clearText() {
      logincontroller.email.clear();
      logincontroller.password.clear();
    }

    return Form(
      key: logincontroller.formkey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 100.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView(
              children: [
                mainText("Delete my account"),
                divder(150.w, 0, 0),
                AppSizes.largeHeightSizedBox,
                textFieldLabel(AppConst.email),
                FormWidget(
                    login: Login(
                        enableText: false,
                        controller: logincontroller.email,
                        hintText: AppConst.email,
                        icon: const Icon(Icons.email),
                        invisible: false,
                        validator: (email) =>
                            logincontroller.validateEmail(email),
                        type: TextInputType.emailAddress,
                        onChange: null,
                        inputFormat: null)),
                AppSizes.smallHeightSizedBox,
                textFieldLabel(AppConst.password),
                FormWidget(
                    login: Login(
                        enableText: false,
                        controller: logincontroller.password,
                        hintText: AppConst.password,
                        icon: const Icon(Icons.lock),
                        invisible: true,
                        validator: (password) =>
                            logincontroller.vaildatePassword(password),
                        type: TextInputType.visiblePassword,
                        onChange: null,
                        inputFormat: null)),
                AppSizes.smallHeightSizedBox,
                ButtonWidget(
                  onTap: () => {
                    autuhcontroller.deleteUserAccount(
                        logincontroller.email.text,
                        logincontroller.password.text),
                    dispose(),
                    clearText()
                  },
                  tilte: 'Delete account',
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
