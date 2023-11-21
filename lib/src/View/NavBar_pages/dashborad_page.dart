import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/dashborad_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: DashBoradWidget(),
      ),
    );
  }
}
