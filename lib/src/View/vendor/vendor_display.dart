import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendor_list_with_search.dart';

class VendorDisplaypage extends StatefulWidget {
  const VendorDisplaypage({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  State<VendorDisplaypage> createState() => _VendorDisplaypageState();
}

class _VendorDisplaypageState extends State<VendorDisplaypage> {
  @override
  Widget build(BuildContext context) {
    return VendorListSearchWidget(
      title: widget.title,
    );
  }
}
