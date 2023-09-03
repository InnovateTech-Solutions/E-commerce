import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/setting/Reset_Password_Widgets/current_pw_widget.dart';
import 'package:flutter/material.dart';

class CurrentPasswordScreen extends StatelessWidget {
  const CurrentPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              CurrentPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
