import 'package:ecommerce/src/constant/color.dart' as color_constants;
import 'package:ecommerce/src/widget/pages_widget/Forms_widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            color_constants.ColorConstants.mainScaffoldBackgroundColor,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              LoginWidget(),
            ],
          ),
        ),
      ),
    );
  }
}