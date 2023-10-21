import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/vendor/vendor_display.dart';
import 'package:profile_part/src/model/categories_model.dart';
import 'package:profile_part/src/widget/Text_Widget/category_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.category, Key? key}) : super(key: key);
  final Categories category;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 100.h,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14.r))),
      child: Stack(
        children: [
          AppContainer(
            imgName: category.image,
            onTap: () => Get.to(
              VendorDisplaypage(title: category.title),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 140.h, left: 20.w),
            child: categoriesText(category.title),
          )
        ],
      ),
    );
  }
}
