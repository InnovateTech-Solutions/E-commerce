import 'package:ecommerce/src/View/Forms/otp_page.dart';
import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/getx/register_controller.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Form(
        key: controller.fromkey,
        child: SizedBox(
          height: 650.h,
          width: 400.w,
          child: ListView(
            padding: EdgeInsets.all(30.h.w),
            children: [
              mainText(AppConst.signUp),
              SizedBox(
                height: AppConst.smallSize.h,
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
                height: AppConst.smallSize.h,
              ),
              textFieldLabel(AppConst.username),
              FormWidget(
                  login: Login(
                      controller: controller.userName,
                      hintText: AppConst.username,
                      icon: const Icon(Icons.abc),
                      invisible: false,
                      validator: (email) => controller.vaildateUserName(email),
                      type: TextInputType.name,
                      onChange: null,
                      inputFormat: null)),
              SizedBox(
                height: AppConst.smallSize.h,
              ),
              textFieldLabel(AppConst.password),
              FormWidget(
                  login: Login(
                      controller: controller.password,
                      hintText: AppConst.password,
                      icon: const Icon(Icons.password),
                      invisible: true,
                      validator: (email) => controller.vaildatePassword(email),
                      type: TextInputType.visiblePassword,
                      onChange: null,
                      inputFormat: null)),
              SizedBox(
                height: AppConst.smallSize.h,
              ),
              textFieldLabel(AppConst.phoneNumber),
              FormWidget(
                  login: Login(
                      controller: controller.phoneNumber,
                      hintText: AppConst.phoneNumber,
                      icon: const Icon(Icons.phone),
                      invisible: false,
                      validator: (email) => controller.vaildPhoneNumber(email),
                      type: TextInputType.number,
                      onChange: null,
                      inputFormat: null)),
              SizedBox(
                height: AppConst.smallSize.h,
              ),
              ButtonWidget(
                  onTap: () {
                    if ((controller.fromkey.currentState!.validate())) {
                      /*controller.createUser(
                        UserModel(
                            email: controller.email.text.trim(),
                            name: controller.userName.text.trim(),
                            password: controller.password.text.trim(),
                            phone: controller.phoneNumber.text.trim()),
                      );

                      controller.registerUser(controller.email.text,
                          controller.password.text.trim());*/

                      RegisterController.instance.phoneAuthentication(
                          controller.phoneNumber.text.trim());
                      Get.to(const OTPScreen());
                    }
                  },
                  tilte: AppConst.signUp)
            ],
          ),
        ));
  }
}
