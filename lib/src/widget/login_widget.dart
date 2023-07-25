import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:ecommerce/src/widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../getx/login_Controller.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.formkey,
      child: ListView(
        padding: EdgeInsets.all(30.h.w),
        children: [
          FormWidget(
              login: Login(
                  controller: controller.email,
                  hintText: "Email",
                  icon: const Icon(Icons.email),
                  invisible: false,
                  validator: (email) => controller.validateEmail(email),
                  type: TextInputType.emailAddress,
                  onChange: null,
                  inputFormat: null)),
          SizedBox(
            height: AppConst.smallSize.h,
          ),
          FormWidget(
              login: Login(
                  controller: controller.password,
                  hintText: "Password",
                  icon: const Icon(Icons.lock),
                  invisible: true,
                  validator: (password) =>
                      controller.vaildatePassword(password),
                  type: TextInputType.none,
                  onChange: null,
                  inputFormat: null)),
          SizedBox(
            height: AppConst.smallSize.h,
          ),
          ElevatedButton(
              onPressed: () => controller.onLogin(),
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
