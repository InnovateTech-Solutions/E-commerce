import 'package:ecommerce/src/widget/pages_wide/sitting/setting_widget.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorConstants.mainTextColor),
        ),
        drawer: const Drawer(),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SettingWidget(),
          ),
        ));
  }
}
