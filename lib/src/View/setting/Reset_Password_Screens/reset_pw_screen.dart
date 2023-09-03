import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/setting/Reset_Password_Widgets/reset_pw_widget.dart';
import 'package:flutter/material.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ResetPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
