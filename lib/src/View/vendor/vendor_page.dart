import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendor_widget.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({required this.vendor, Key? key}) : super(key: key);
  final VendorModel vendor;
  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: VendorWidget(
          vendor: widget.vendor,
        ),
      ),
    );
  }
}
