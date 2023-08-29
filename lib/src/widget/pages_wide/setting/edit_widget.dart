import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constant/app_const.dart';
import '../../../getx/login_Controller.dart';
import '../../../model/login_model.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../custom_Widget.dart/form_widget.dart';

class EditWidget extends StatelessWidget {
  final usercontroller = Get.put(UserRepository());
  final controller = Get.put(LoginController());

  EditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SafeArea(
          child: Column(
        children: [
          imagepicker(),
          Align(
            alignment: Alignment.centerLeft,
            child: textFieldLabel(AppConst.username),
          ),
          FormWidget(
              login: Login(
                  controller: controller.email,
                  hintText: usercontroller.userModel.email,
                  icon: const Icon(Icons.email),
                  invisible: false,
                  validator: (email) => controller.validateEmail(email),
                  type: TextInputType.emailAddress,
                  onChange: null,
                  inputFormat: null)),
          SizedBox(
            height: AppConst.medium.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: textFieldLabel(AppConst.email),
          ),
          FormWidget(
              login: Login(
                  controller: controller.email,
                  hintText: AppConst.email,
                  icon: const Icon(Icons.lock),
                  invisible: true,
                  validator: (password) =>
                      controller.vaildatePassword(password),
                  type: TextInputType.visiblePassword,
                  onChange: null,
                  inputFormat: null)),
        ],
      )),
    );
  }

  GestureDetector imagepicker() {
    return GestureDetector(
      onTap: () async {
        usercontroller.pickUpImage();
      },
      child: Container(
        width: 150.w,
        height: 150.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Image.network(
          usercontroller.getUserImageUrl(),
          width: 100.w,
          height: 100.h,
        ),
      ),
    );
  }
}
