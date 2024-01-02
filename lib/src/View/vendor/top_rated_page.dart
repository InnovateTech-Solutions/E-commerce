import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/vendor/top_rated_widget.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: topRatedAppBar("Top Rated"),
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: TopRatedWidget(),
      ),
    );
  }
}
