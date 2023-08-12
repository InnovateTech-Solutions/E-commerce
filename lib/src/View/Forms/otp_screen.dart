import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_widget/Forms_widgets/otp_widget.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: Center(
        child: OTPWidget(),
      ),
    );
  }
}
