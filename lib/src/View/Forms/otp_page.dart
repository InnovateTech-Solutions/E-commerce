import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../widget/pages_widget/Forms_widgets/otp_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: const Center(
        child: OTPWidget(),
      ),
    );
  }
}
