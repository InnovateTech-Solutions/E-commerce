import 'package:ecommerce/src/widget/pages_wide/sitting/sitting_widget.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class SittingPage extends StatelessWidget {
  const SittingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SittingWidget(),
          ),
        ));
  }
}
