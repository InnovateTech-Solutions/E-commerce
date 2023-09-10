import 'package:flutter/material.dart';
import '../../constant/color.dart';
import '../../widget/pages_widget/start_widget.dart/intropage_widget.dart';

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
