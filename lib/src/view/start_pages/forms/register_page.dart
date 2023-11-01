import 'package:flutter/material.dart';
import 'package:vendor_app/src/constant/color.dart';
import 'package:vendor_app/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:vendor_app/src/widget/pages_widget/forms/Register/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        appBar: thirdAppBar(),
        body: const RegisterWidget(),
      ),
    );
  }
}
