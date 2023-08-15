import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/widget/pages_wide/sitting/edit_widget.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: Column(
          children: [EditWidget()],
        ));
  }
}
