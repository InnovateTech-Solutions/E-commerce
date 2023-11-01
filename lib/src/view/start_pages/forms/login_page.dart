import 'package:flutter/material.dart';
import 'package:vendor_app/src/constant/color.dart';
import 'package:vendor_app/src/widget/pages_widget/forms/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const LoginWidget(),
      ),
    );
  }
}
