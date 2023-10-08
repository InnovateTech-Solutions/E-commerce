import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/update_widget.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        appBar: profileAppBar(),
        body: const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: UpdateProfileWidget(),
            )),
      ),
    );
  }
}
