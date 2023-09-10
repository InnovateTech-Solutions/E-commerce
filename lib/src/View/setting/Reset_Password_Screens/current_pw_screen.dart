import 'package:flutter/material.dart';

import '../../../constant/color.dart';
import '../../../widget/pages_widget/setting/Reset_Password_Widget.dart/current_pw_widget.dart';

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
