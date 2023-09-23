import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/profile_widget.dart';

import '../../constant/color.dart';
import '../../widget/custom_Widget.dart/drawer_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorConstants.mainTextColor),
        ),
        drawer: Drawer(
          child: DrawerWidget(),
        ),
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ProfileWidget(),
          ),
        ));
  }
}
