import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({required this.product, Key? key}) : super(key: key);
  final Product product;
  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
          elevation: 0,
          pinned: true,
          centerTitle: false,
          expandedHeight: 300.h,
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  height: 250.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r)),
                    image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                        fit: BoxFit.cover),
                  ))),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
