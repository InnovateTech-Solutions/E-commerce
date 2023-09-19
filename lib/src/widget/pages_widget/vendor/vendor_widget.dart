import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/product_model.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({required this.product, Key? key}) : super(key: key);
  final Product product;
  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Container(
              height: 250.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r)),
                image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                    fit: BoxFit.cover),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Container(
                height: 500.h,
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: ColorConstants.secondaryScaffoldBacground,
                  borderRadius: BorderRadius.circular(25.0.r),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20),
            child: Container(
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: ColorConstants.secondaryScaffoldBacground,
                borderRadius: BorderRadius.circular(25.0.r),
              ),
              child: Center(
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorConstants.mainTextColor,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
