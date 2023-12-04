import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/getx/booking_controller.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/getx/payment_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/booking_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/partial_widget/Icare%20policies/deposit_policy.dart';
import 'package:profile_part/src/widget/partial_widget/Icare%20policies/terms_conditions.dart';
import 'package:profile_part/src/widget/partial_widget/confirm_partial/confirm_content.dart';
import 'package:profile_part/src/widget/partial_widget/confirm_partial/price_and_continue.dart';

import '../../../repository/payment_reposiory/stripe_keys.dart';

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
  final paymentController = Get.put(PaymentController());
  RxString note = 'Add Booking notes'.obs;

  @override
  Widget build(BuildContext context) {
    int totalPrice = (controller.counter.value * 0.1).round();
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
            priceAndConfirm(
                controller.counter.value, controller.cartItems.length,
                () async {
              await makePayment(
                context,
                totalPrice,
              );
            })
          ],
        ),
      ),
    );
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context, int amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              customerId: 'Icare',
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay'));

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
      
    } catch (err) {
      throw Exception(err);
    }
  }

  int roundToNearestTen(double amount) {
    // Multiply by 100 to shift the decimal point two places to the right
    int multipliedAmount = (amount * 100).round();

    // Round to the nearest ten
    int roundedAmount = (multipliedAmount / 10).round() * 10;

    return roundedAmount;
  }

displayPaymentSheet(BuildContext context) async {
  try {
    await Stripe.instance.presentPaymentSheet().then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: GestureDetector(
            onTap: () {
              Get.offAll(MainPage());
              controller.clearCart();
              bookingController.createBooking(Booking(
                vendorName: vendorModel.name,
                date: confirmDate,
                time: confirmTime,
                userEmail: userController.email.value,
                services: controller.cartItemsNames,
                note: note.value,
                totalPrice: controller.counter.value,
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100.0,
                ),
                SizedBox(height: 10.0),
                secondaryConfirmText("Payment Successful!"),
                payText('Tap to get the main page'),
              ],
            ),
          ),
        ),
      );

      paymentIntent = null;
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  } on StripeException catch (e) {
    print('Error is:---> $e');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      ),
    );
  } catch (e) {
    print('$e');
  }
}

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
