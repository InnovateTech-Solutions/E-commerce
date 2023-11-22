import 'package:flutter/widgets.dart';

import '../Text_Widget/dashboard_text.dart';
import '../partial_widget/dashboard_partial.dart/seemore_widget.dart';

DashboardTitle(String title, VoidCallback ontap) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [dashoboardMainText(title), SeeMore(onTap: ontap)],
    ),
  );
}
