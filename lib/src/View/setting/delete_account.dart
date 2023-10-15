import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/delete_accountwidget.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          appBar: thirdAppBar(),
          body: const DeleteAccountWidget()),
    );
  }
}
