import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/service_model.dart';
import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

import '../../../user_actions/Dialogs/confirm_dialog.dart';

class Confirm {
  static Row appointmentImg(String image) {
    return Row(
      children: [
        Container(
            width: 347.w,
            height: 70.h,
            margin: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 6.0.w),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2.r,
                    blurRadius: 3.r,
                    offset: const Offset(0, 2))
              ],
              borderRadius: BorderRadius.circular(10.0.r),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            )),
      ],
    );
  }

  static Container appointmentDetails(String vendorName, String? vendorAdress) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: secondaryConfirmText(vendorName),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              vendorAdress ?? 'There is no address',
              style: TextStyle(
                  color: ColorConstants.mainTextColor, // Customize text color
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.w300
                  // Customize text size
                  ),
            ),
          )
        ],
      ),
    );
  }

  static Container appointmentDate(String formatted, String confirmTime) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: ColorConstants.mainTextColor,
            size: 35,
          ),
          AppSizes.smallWidthSizedBox,
          Column(
            children: [
              secondaryConfirmText(formatted),
              Padding(
                padding: EdgeInsets.only(right: 60.w),
                child: secondaryConfirmText(confirmTime),
              )
            ],
          )
        ],
      ),
    );
  }

  static Container serviceContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.centerLeft,
      child: mainConfirmText('Services'),
    );
  }

  static SizedBox serviceList(List<ServiceModel> cartItems) {
    return SizedBox(
      height: 53.0.h * cartItems.length,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                secondaryConfirmText(cartItems[index].name),
                Expanded(child: Container()),
                secondaryConfirmText(cartItems[index].price)
              ],
            ),
          );
        },
      ),
    );
  }

  static Container totalContainer(int total) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          secondaryConfirmText('Total'),
          Expanded(child: Container()),
          secondaryConfirmText('${total} BD'),
        ],
      ),
    );
  }

  static Container noteContainer(BuildContext context,
      TextEditingController noteController, RxString note) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Row(
        children: [
          Icon(
            Icons.event_note_outlined,
            color: ColorConstants.mainTextColor,
            size: 35,
          ),
          AppSizes.smallWidthSizedBox,
          Column(
            children: [
              secondaryConfirmText('Booking notes'),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                child: Obx(
                  () => note.value.length > 20
                      ? thirdConfirmText('your note has been seened')
                      : thirdConfirmText(note.value),
                ),
              )
            ],
          ),
          Expanded(
              child: TextButton(
                  onPressed: () => DialogManager.showAddNoteDialog(
                      context, noteController, note),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: ColorConstants
                            .mainTextColor, // Customize text color
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w300
                        // Customize text size
                        ),
                  )))
        ],
      ),
    );
  }
}
