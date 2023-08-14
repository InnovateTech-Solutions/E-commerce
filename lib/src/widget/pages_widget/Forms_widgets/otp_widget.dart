import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/getx/otp_controller.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({Key? key}) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  var otp;
  final controller = Get.put(OTPcontroller());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConst.largeSize.h,
        ),
        mainText(AppConst.verificationOTP),
        constDivider(),
        SizedBox(
          height: AppConst.largeSize.h,
        ),
        textFieldLabel("we have sent the code verification to your email "),
        SizedBox(
          height: AppConst.medium.h,
        ),
        OtpTextField(
          mainAxisAlignment: MainAxisAlignment.center,
          numberOfFields: 6,
          fillColor: ColorConstants.secondaryScaffoldBacground,
          filled: true,
          onSubmit: (code) {
            otp = code;
            OTPcontroller.instance.verifyOTP(otp);
          },
        ),
        SizedBox(
          height: AppConst.medium.h,
        ),
        ButtonWidget(
            onTap: () => OTPcontroller().verifyOTP(otp), tilte: "Submit")
      ],
    );
  }
}
