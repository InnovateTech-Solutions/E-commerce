import 'package:flutter/material.dart';
import 'package:vendor_app/src/constant/color.dart';
import 'package:vendor_app/src/widget/pages_widget/forms/sign_in_up_widget.dart';

class SignUpInPage extends StatelessWidget {
  const SignUpInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          body: const Center(child: SignUpInWidget())),
    );
  }
}
