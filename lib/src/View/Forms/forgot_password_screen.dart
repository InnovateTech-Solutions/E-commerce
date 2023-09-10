import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/app_const.dart';
import '../../constant/color.dart';
import '../../getx/forget_controller.dart';
import '../../getx/login_Controller.dart';
import '../../model/login_model.dart';
import '../../widget/Text_Widget/form_text.dart';
import '../../widget/constant_widget/constant_widget.dart';
import '../../widget/custom_Widget.dart/app_text.dart';
import '../../widget/custom_Widget.dart/button_widget.dart';
import '../../widget/custom_Widget.dart/form_widget.dart';

class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  final controller = Get.put(LoginController());
  final forgetController = Get.put(ForgetPasswordcontroller());

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: SizedBox(
          height: 550.h,
          width: 400.w,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(30.h.w),
            children: [
              SizedBox(
                height: 100.h,
              ),
              mainText("FORGOT PASSWORD"),
              constDivider(),
              SizedBox(
                height: AppConst.smallSize.h,
              ),
              const AppText(text: "WE WILL SEND YOU RESET INSTRUCTIONS"),
              SizedBox(
                height: AppConst.medium.h,
              ),
              textFieldLabel(AppConst.email),
              FormWidget(
                  login: Login(
                      enable: true,
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
              ButtonWidget(
                onTap: () => forgetController.passwordRest(
                    context, controller.email.text.trim()),
                tilte: "RESET PASSWORD",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
