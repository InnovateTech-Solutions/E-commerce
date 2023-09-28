import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/Text_Widget/setting_text.dart';

class mapDialog extends StatelessWidget {
  const mapDialog({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Stack(
          children: [
            Container(
              width: 500.w,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: ColorConstants.mainScaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Container(
                      height: 100.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                      )),
                  settingText(title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
