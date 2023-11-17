import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/payment_reposiory/payment_manger.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  Future<void> makePayment(
      {required BuildContext context,
      required int amount,
      required VoidCallback callback,
      required VoidCallback booking}) async {
    int totalPrice = (amount * 0.1).round();

    return PaymentManger.instance
        .makePayment(context, totalPrice.toString(), callback, booking);
  }
}
