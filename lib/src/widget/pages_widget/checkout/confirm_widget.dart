import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/booking_controller.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/booking_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/partial_widget/Icare%20policies/deposit_policy.dart';
import 'package:profile_part/src/widget/partial_widget/Icare%20policies/terms_conditions.dart';
import 'package:profile_part/src/widget/partial_widget/confirm_partial/confirm_content.dart';
import 'package:profile_part/src/widget/partial_widget/confirm_partial/price_and_continue.dart';

class ConfirmWidget extends GetView<ServiceController> {
  ConfirmWidget(
      {required this.vendorModel,
      required this.confirmDate,
      required this.confirmTime,
      super.key});
  final VendorModel vendorModel;
  final String confirmDate;
  final String confirmTime;
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {


    RxString note = 'Add Booking notes'.obs;
    TextEditingController noteController = TextEditingController();
    String formatted = DateFormat.yMMMEd().format(DateTime.parse(confirmDate));
    Get.put(ServiceController());
    return SafeArea(
      child: Scaffold(
        appBar: confirmAppBar(vendorModel),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Confirm.appointmentImg(vendorModel.image),
                  Confirm.appointmentDetails(
                      vendorModel.name, vendorModel.address),
                  AppSizes.smallHeightSizedBox,
                  AppConst.pageDivider,
                  AppSizes.smallHeightSizedBox,
                  Confirm.appointmentDate(formatted, confirmTime),
                  AppSizes.smallHeightSizedBox,
                  AppConst.pageDivider,
                  AppSizes.smallHeightSizedBox,
                  Confirm.noteContainer(context, noteController, note),
                  AppSizes.mediumHeightSizedBox,
                  Confirm.serviceContainer(),
                  Confirm.serviceList(controller.cartItems),
                  AppSizes.xsmallHeightSizedBox,
                  AppConst.pageDivider,
                  Confirm.totalContainer(controller.counter.value),
                  AppSizes.smallHeightSizedBox,
                  Deposit.title(),
                  Deposit.content(),
                  TermsConditions.title(),
                  TermsConditions.content(),
                ],
              ),
            ),

            priceAndConfirm(controller.counter.value,
                controller.cartItems.length, () => bookingController.createBooking(Booking(vendorName: vendorModel.name, date: confirmDate, time: confirmTime, userEmail: userController.email.value, services: controller.cartItemsNames, note: note.value, totalPrice: controller.counter.value )))
          ],
        ),
      ),
    );
  }
}
