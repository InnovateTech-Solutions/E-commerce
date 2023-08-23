import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_widget/Forms_widgets/update_widget.dart';
import 'package:flutter/material.dart';

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
