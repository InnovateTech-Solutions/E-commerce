import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';

class ConfirmWidget extends StatelessWidget {
  const ConfirmWidget({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: confirmAppBar(),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 220,
                    height: 1150,
                    margin: EdgeInsets.symmetric(
                        vertical: 6.0.h, horizontal: 6.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.r),
                      image: DecorationImage(
                          image: NetworkImage(vendorModel.image),
                          fit: BoxFit.cover),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
