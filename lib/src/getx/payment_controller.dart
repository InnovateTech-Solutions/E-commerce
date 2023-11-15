import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/repository/payment_repository.dart/payment_manger%20.dart';

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
