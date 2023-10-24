import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/user_actions/Dialogs/confirm_dialog.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';

class ConfirmWidget extends GetView<ServiceController> {
  ConfirmWidget(
      {required this.vendorModel,
      required this.confirmDate,
      required this.confirmTime,
      super.key});
  final VendorModel vendorModel;
  final String confirmDate;
  final String confirmTime;

  @override
  Widget build(BuildContext context) {
    RxString note = 'Add Booking notes'.obs;
    TextEditingController noteController = TextEditingController();

    String formatted = DateFormat.yMMMEd().format(DateTime.parse(confirmDate));
    Get.put(ServiceController());
    return SafeArea(
      child: Scaffold(
        appBar: confirmAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 347.w,
                          height: 70.h,
                          margin: EdgeInsets.symmetric(
                              vertical: 6.0.h, horizontal: 6.0.w),
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
                                image: NetworkImage(vendorModel.image),
                                fit: BoxFit.cover),
                          )),
                    ],
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: subvendorText(vendorModel.name),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            vendorModel.address ?? 'There is no address',
                            style: TextStyle(
                                color: ColorConstants
                                    .mainTextColor, // Customize text color
                                fontSize: 10.0.sp,
                                fontWeight: FontWeight.w300
                                // Customize text size
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AppSizes.smallHeightSizedBox,
                  Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                    color: ColorConstants.textFiledmColor,
                  ),
                  AppSizes.smallHeightSizedBox,
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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
                            subvendorText(formatted),
                            Padding(
                              padding: EdgeInsets.only(right: 70.w),
                              child: subvendorText(confirmTime),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  AppSizes.smallHeightSizedBox,
                  Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                    color: ColorConstants.textFiledmColor,
                  ),
                  AppSizes.smallHeightSizedBox,
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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
                            subvendorText('Booking notes'),
                            Container(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Obx(
                                () => note.value.length > 20
                                    ? Text('your note has been seened')
                                    : AutoSizeText(
                                        note.value,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .mainTextColor, // Customize text color
                                            fontSize: 10.0.sp,
                                            fontWeight: FontWeight.w400
                                            // Customize text size
                                            ),
                                      ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                            child: TextButton(
                                onPressed: () =>
                                    DialogManager.showAddNoteDialog(
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
                  ),
                  AppSizes.mediumHeightSizedBox,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: mainVendorText('Services'),
                  ),
                  SizedBox(
                    height: 53.0.h * controller.cartItems.length,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              subvendorText(controller.cartItems[index].name),
                              subvendorText(controller.cartItems[index].price)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AppSizes.xsmallHeightSizedBox,
                  Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                    color: ColorConstants.textFiledmColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: ColorConstants
                                .mainTextColor, // Customize text color
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold
                            // Customize text size
                            ),
                      ),
                      subvendorText('${controller.counter} BD'),
                    ],
                  ),
                  AppSizes.smallHeightSizedBox,
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: mainVendorText('Deposit policy'),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      'As part of our commitment to delivering quality care services, iCare App requires a deposit of 10% of the total invoice amount. This deposit is necessary to secure your service reservation and initiate the scheduling process. The deposit is applicable to all services offered by iCare App.',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.mainTextColor)),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: mainVendorText('additional terms and conditions'),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      'Deposits are non-refundable, you can reschedule your appointment and your deposit will be transferred over to your future booking. If you are unable to reschedule, please contact us at least 48 hours before your appointment.',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.mainTextColor)),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
            Obx(
              () => controller.cartItems.isEmpty
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity.w,
                        height: 75.h,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.r,
                                  blurRadius: 3.r,
                                  offset: const Offset(0, 2)),
                            ],
                            color: ColorConstants.mainScaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BD ${controller.counter.toString()}",
                                  style: TextStyle(
                                    color: ColorConstants
                                        .mainTextColor, // Customize text color
                                    fontSize: 16.0.sp, // Customize text size
                                  ),
                                ),
                                Text(
                                  '${controller.cartItems.length} Service',
                                  style: TextStyle(
                                      color: ColorConstants
                                          .mainTextColor, // Customize text color
                                      fontSize: 10.0.sp,
                                      fontWeight: FontWeight.w300
                                      // Customize text size
                                      ),
                                ),
                              ],
                            ),
                            ProductButton(
                              onTap: () => {},
                              title: 'Confrim',
                            )
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
