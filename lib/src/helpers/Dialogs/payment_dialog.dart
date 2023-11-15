import 'package:flutter/material.dart';

abstract class PaymentDialog {
  static AlertDialog confirmDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100.0,
          ),
          SizedBox(height: 10.0),
          Text("Payment Successful!"),
        ],
      ),
    );
  }

  static AlertDialog filedDialog() {
    return AlertDialog(
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
  }
}
