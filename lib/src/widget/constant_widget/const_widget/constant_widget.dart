import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/Forms/register_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/constant/lang_list.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/button_model.dart';
import 'package:profile_part/src/model/drawer_button.dart';
import 'package:profile_part/src/model/history_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

constDivider() {
  return Divider(
    thickness: 3,
    color: ColorConstants.secondaryScaffoldBacground,
    indent: 20,
    endIndent: 30,
  );
}

class NotificationSwitch extends StatelessWidget {
  final toggleController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Switch(
        activeColor: ColorConstants.subTextColor,
        value: toggleController.isSwitched.value,
        onChanged: (value) {
          toggleController.saveSwitchState(value);
        },
      ),
    );
  }
}

dontHaveAccountRow() {
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: GestureDetector(
      onTap: () =>
          Get.to(const RegisterPage(), transition: Transition.rightToLeft),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "don’t have account?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: ColorConstants.mainTextColor)),
          ),
          GestureDetector(
            child: Text(
              "Create one",
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

drawerWidget(AppDrawerButton drawer) {
  return InkWell(
    onTap: drawer.onTap,
    child: Row(
      children: [
        drawer.icon,
        AppSizes.mediumWidthSizedBox,
        textFieldLabel(drawer.title)
      ],
    ),
  );
}

profileWidget(Button profile) {
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

switchButton(bool light) {
  return Switch(
    value: light,
    activeColor: Colors.red,
    onChanged: (bool value) {},
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

historyContainer(HistoryModel historyModel) {
  return GestureDetector(
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                  height: 70.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: ColorConstants.secondaryScaffoldBacground,
                      image: DecorationImage(
                          image: NetworkImage(historyModel.image)))),
              AppSizes.smallWidthSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  historyText(historyModel.vendor),
                  historyText(historyModel.time),
                ],
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: ColorConstants.mainTextColor,
        )
      ],
    ),
  );
}
