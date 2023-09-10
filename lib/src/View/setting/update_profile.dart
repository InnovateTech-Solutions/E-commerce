import 'package:flutter/material.dart';
import '../../constant/color.dart';
import '../../widget/pages_widget/setting/update_widget.dart';

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
