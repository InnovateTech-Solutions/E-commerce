import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_widget/Forms_widgets/register_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const Center(
          child: RegisterWidget(),
        ),
      ),
    );
  }
}
