import 'package:flutter/material.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/confirm_widget.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage(
      {required this.vendorModel,
      required this.confirmDate,
      required this.confirmTime,
      super.key});
  final VendorModel vendorModel;
  final String confirmDate;
  final String confirmTime;
  @override
  Widget build(BuildContext context) {
    return ConfirmWidget(
      vendorModel: vendorModel,
      confirmDate: confirmDate,
      confirmTime: confirmTime,
    );
  }
}
