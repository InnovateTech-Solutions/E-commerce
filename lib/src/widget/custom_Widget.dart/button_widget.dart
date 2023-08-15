import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({Key? key, required this.onTap, required this.tilte})
      : super(key: key);
  final String tilte;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 143.w,
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: ColorConstants.secondaryScaffoldBacground),
        child: Center(
          child: Text(
            tilte,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ColorConstants.mainTextColor)),
          ),
        ),
      ),
    );
  }
}
