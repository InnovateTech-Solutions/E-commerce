import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendor_widget.dart';

class VendorPage extends GetView {
  const VendorPage({required this.vendor, Key? key}) : super(key: key);
  final VendorModel vendor;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: VendorWidget(
          vendor: vendor,
        ),
      ),
    );
  }
}
