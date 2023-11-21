import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';

class SeeMore extends StatefulWidget {
  const SeeMore({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('see more',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.mainTextColor))),
        ],
      ),
    );
  }
}
