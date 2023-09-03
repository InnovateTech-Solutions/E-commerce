import 'package:ecommerce/src/repository/Forget_Password/reset_pw_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();
  final currentFormkey = GlobalKey<FormState>();
  final resetFormkey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();


  validatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  Future<void> changePassword() async {
    if (resetFormkey.currentState!.validate()) {
      ResetPasswordRepository().changePassword(newPassword.text.trim(), confirmPassword.text.trim());
    }
  }

    Future<void> reAuth() async {
    if (currentFormkey.currentState!.validate()) {
      ResetPasswordRepository().reAuth(oldPassword.text.trim()
      );
    }
  }

}
