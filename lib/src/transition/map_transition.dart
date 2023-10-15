import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:shimmer/shimmer.dart';

class MapTransition extends StatelessWidget {
  const MapTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Icon(
          Icons.location_on_outlined,
          size: 250,
          color: ColorConstants.mainScaffoldBackgroundColor,
        ),
        baseColor: ColorConstants.secondaryScaffoldBacground,
        highlightColor: ColorConstants.mainScaffoldBackgroundColor);
  }
}
