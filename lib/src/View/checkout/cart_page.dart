import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/cart_widget.dart';

class CartPage extends StatelessWidget {
  CartPage({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cartAppbar(),
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: CartWidget(
        vendorModel: vendorModel,
      ),
    );
  }
}
