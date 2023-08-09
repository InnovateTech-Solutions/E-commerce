import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordRepository extends GetxController {
  static ForgetPasswordRepository get instance => Get.find();

  Future<void> passwordReset(context, email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }
}
