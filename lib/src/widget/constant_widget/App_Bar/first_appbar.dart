import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';

firstAppBar() {
  return AppBar(
    backgroundColor: ColorConstants.secondaryScaffoldBacground,
    elevation: 0,
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: ColorConstants.mainTextColor,
              ))
        ],
      )
    ],
  );
}
