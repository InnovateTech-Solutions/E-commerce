import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/update_widget.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: UpdateProfileWidget(),
            )),
      ),
    );
  }
}
