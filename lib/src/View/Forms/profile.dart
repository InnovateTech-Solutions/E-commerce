import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/profile_widget.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          child: ProfileWidget(),
        ));
  }
}
