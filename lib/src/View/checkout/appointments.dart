import 'package:flutter/material.dart';
import 'package:profile_part/src/model/vendor_model.dart';

import '../../widget/pages_widget/checkout/appointments_widget.dart';

class Appointments extends StatelessWidget {
  const Appointments({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AppointmentsWidget(
          vendorModel: vendorModel,
        ),
      ),
    );
  }
}
