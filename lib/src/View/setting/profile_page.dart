import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/Forms_widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ProfileWidget(),
          ),
        ));
  }
}
