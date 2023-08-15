import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/Text_Widget/form_text.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  final SvgPicture icon;
  final String title;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          textFieldLabel(title),
          const Spacer(),
          icon,
        ],
      ),
    );
  }
}
