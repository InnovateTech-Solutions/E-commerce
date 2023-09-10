import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../widget/pages_widget/Forms_widgets/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const Center(
          child: RegisterWidget(),
        ),
      ),
    );
  }
}
