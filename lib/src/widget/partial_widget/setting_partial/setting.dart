import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/widget/Text_Widget/setting_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';

import '../../constant_widget/sizes/sized_box.dart';

Widget settingColumn() {
  return Column(
    children: [
      AppSizes.mediumHeightSizedBox,
      Align(alignment: Alignment.centerLeft, child: mainSettingText("Setting")),
      divder(150.w, 0, 0),
    ],
  );
}
