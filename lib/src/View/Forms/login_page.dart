import 'package:ecommerce/src/widget/pages_wide/Forms_widgets/login_widget.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              LoginWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
