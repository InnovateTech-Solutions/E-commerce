import 'package:flutter/material.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/confirm_widget.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  Widget build(BuildContext context) {
    return ConfirmWidget(
      vendorModel: vendorModel,
    );
  }
}
