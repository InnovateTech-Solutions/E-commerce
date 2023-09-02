import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/Forms/update_profile.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/first_appbar.dart';
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
        appBar: firstAppBar(),
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        body: const DashBoradWidget(),
      ),
    );
  }

  Column buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () => Get.to(const UpdateProfile()),
              child: const Text('update profile')),
        ),
        ElevatedButton(
            onPressed: () => AuthenticationRepository().logout(),
            child: const Text('log out')),
      ],
    );
  }
}
