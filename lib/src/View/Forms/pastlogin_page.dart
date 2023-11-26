import 'package:flutter/material.dart';
import 'package:profile_part/src/View/Forms/pastlogin_widget.dart';
import 'package:profile_part/src/constant/color.dart';

class PastLoginPage extends StatelessWidget {
  const PastLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: PastLoginWidget(),
    ));
  }
}
