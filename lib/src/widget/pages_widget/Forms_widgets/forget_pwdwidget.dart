import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/forget_controller.dart';
import 'package:profile_part/src/getx/login_Controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final forgetController = Get.put(ForgetPasswordcontroller());
    TextEditingController email = TextEditingController();

    return Column(
      children: [
        SizedBox(
          height: AppConst.largeSize.h,
        ),
        Expanded(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            children: [
              mainText("FORGOT PASSWORD"),
              constDivider(),
              AppSizes.smallHeightSizedBox,
              textFieldLabel("WE WILL SEND YOU RESET INSTRUCTIONS"),
              AppSizes.mediumHeightSizedBox,
              textFieldLabel(AppConst.email),
              FormWidget(
                  login: Login(
                enableText: false,
                controller: email,
                hintText: AppConst.email,
                icon: const Icon(Icons.email),
                invisible: false,
                validator: (email) => controller.validateEmail(email),
                type: TextInputType.emailAddress,
                onChange: null,
                inputFormat: null,
              )),
              AppSizes.mediumHeightSizedBox,
              ButtonWidget(
                onTap: () => {
                  forgetController.passwordRest(context, email.text.trim()),
                },
                title: "RESET PASSWORD",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
