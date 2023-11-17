import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/repository/payment_reposiory/stripe_keys.dart';
import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';

class PaymentManger extends GetxController {
  static PaymentManger get instance => Get.find();
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context, String amount,
      VoidCallback callback, VoidCallback booking) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Icare'));

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context, callback);
      booking;
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(BuildContext context, VoidCallback callback) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: GestureDetector(
                    onTap: () => {Get.offAll(MainPage()), callback},
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
                        payText('Tap to get the main pahe'),
                      ],
                    ),
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
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
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  // static Future<void> makePayment(int amount, String currency) async {
  //   try {
  //     String clientSecret =
  //         await _getClientSecret((amount * 100).toString(), currency);
  //     await _initializePaymentSheet(clientSecret);
  //     await Stripe.instance.presentPaymentSheet();
  //   } catch (error) {
  //     throw Exception(error.toString());
  //   }
  // }

  // static Future<void> _initializePaymentSheet(String clinetSecret) async {
  //   await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: 'vendor name'));
  // }

  // static Future<String> _getClientSecret(String amount, String currency) async {
  //   Dio dio = Dio();
  //   var response = await dio.post(
  //     'https://api.stripe.com/v1/payment_intents',
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer ${ApiKeys.secretKey}',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //     ),
  //     data: {
  //       'amount': amount,
  //       'currency': currency,
  //     },
  //   );
  //   return response.data["client_secret"];
  // }
}
