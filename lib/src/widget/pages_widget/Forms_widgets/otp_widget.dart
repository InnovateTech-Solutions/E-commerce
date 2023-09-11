import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/app_const.dart';
import '../../../getx/otp_controller.dart';
import '../../Text_Widget/form_text.dart';
import '../../constant_widget/constant_widget.dart';
import '../../custom_Widget.dart/button_widget.dart';

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
        /* OtpTextField(
          mainAxisAlignment: MainAxisAlignment.center,
          numberOfFields: 6,
          fillColor: ColorConstants.secondaryScaffoldBacground,
          filled: true,
          onSubmit: (code) {
            otp = code;
            OTPcontroller.instance.verifyOTP(otp);
          },
        ),*/
        SizedBox(
          height: AppConst.medium.h,
        ),
        ButtonWidget(
            onTap: () => OTPcontroller().verifyOTP(otp), tilte: "Submit")
      ],
    );
  }
}
