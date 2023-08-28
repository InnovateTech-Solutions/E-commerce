import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';

import '../../widget/pages_wide/setting/update_widget.dart';

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
