import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({Key? key}) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        mainText(AppConst.verificationOTP),
        constDivider(),
      ],
    );
  }
}
