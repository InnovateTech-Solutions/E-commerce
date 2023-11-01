import 'package:flutter/material.dart';
import 'package:vendor_app/src/constant/color.dart';
import 'package:vendor_app/src/widget/pages_widget/forms/Register/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: const MapWidget(),
      ),
    );
  }
}
