import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendors_display.dart';

import '../../widget/constant_widget/App_Bar/app_bar.dart';

class VendorDisplaypage extends StatefulWidget {
  const VendorDisplaypage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<VendorDisplaypage> createState() => _VendorDisplaypageState();
}

class _VendorDisplaypageState extends State<VendorDisplaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      appBar: productsAppBar(widget.title),
      body: VendorDisplayWidget(
        category: widget.title,
      ),
    );
  }
}
