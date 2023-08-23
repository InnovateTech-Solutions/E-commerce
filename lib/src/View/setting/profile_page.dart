import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/Forms_widgets/profile_widget.dart';
import 'package:flutter/material.dart';

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
        drawer: const Drawer(
          child: DrawerWidget(),
        ),
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ProfileWidget(),
          ),
        ));
  }
}
