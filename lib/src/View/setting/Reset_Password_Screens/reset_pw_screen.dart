import 'package:flutter/material.dart';

import '../../../constant/color.dart';
import '../../../widget/pages_widget/setting/Reset_Password_Widget.dart/reset_pw_widget.dart';

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
