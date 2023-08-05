import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../getx/login_Controller.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
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
            loginMainText(),
            SizedBox(
              height: AppConst.medium.h,
            ),
            textfiledLabel(AppConst.email),
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
            textfiledLabel(AppConst.password),
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
            forgetPaawordText(),
            SizedBox(
              height: AppConst.medium.h,
            ),
            ButtonWidget(onTap: () => controller.onLogin(), tilte: "Login"),
            dontHaveAccountRow()
          ],
        ),
      ),
    );
  }
}
