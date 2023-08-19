import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/constant/lang_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/profile_model.dart';
import '../Text_Widget/form_text.dart';

constDivider() {
  return Divider(
    thickness: 3,
    color: ColorConstants.secondaryScaffoldBacground,
    indent: 20,
    endIndent: 30,
  );
}

dontHaveAccountRow() {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "don’t have account?".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.mainTextColor)),
        ),
        GestureDetector(
          child: Text(
            "Create one".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: ColorConstants.mainTextColor)),
          ),
        )
      ],
    ),
  );
}

Container divder(double width, double left, double right) {
  return Container(
    height: 3.h,
    width: width,
    color: ColorConstants.secondaryScaffoldBacground,
    margin: EdgeInsets.only(right: right, left: left),
  );
}

switchButton(bool light) {
  return Switch(
    value: light,
    activeColor: Colors.red,
    onChanged: (bool value) {},
  );
}

profileWidget(Profile profile) {
  return InkWell(
    onTap: profile.onTap,
    child: Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        textFieldLabel(profile.title),
        const Spacer(),
        profile.icon,
      ],
    ),
  );
}

buildDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: blueText("Choose a Language"),
          content: SizedBox(
            width: 150.w,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: blueText(Languages.locale[index]['name']),
                    onTap: () {
                      updateLanguage(Languages.locale[index]['locale']);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return divder(60.w, 0, 0);
                },
                itemCount: Languages.locale.length),
          ),
        );
      });
}

updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}
