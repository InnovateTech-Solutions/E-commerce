import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';

import '../../widget/pages_wide/start_widget/intropage_widget.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          body: const Center(child: IntroWidget())),
    );
  }
}
