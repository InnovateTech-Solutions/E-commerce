import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/setting_widget.dart';

import '../../widget/constant_widget/App_Bar/app_bar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: thirdAppBar(), body: SettingWidget());
  }
}
