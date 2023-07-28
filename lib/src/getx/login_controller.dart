import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  validateEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return 'Email is not vaild';
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  signIn() async {
    AuthenticationRepository().login(email.text.trim(), password.text.trim());

    password.clear();
  }

  Future onLogin() async {
    if (formkey.currentState!.validate()) {
      signIn();
      Get.snackbar("Success", "Login successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorsuccessful);
      return;
    } else {
      Get.snackbar("Error", "Login unsuccessful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
  }

  void successMassage() {
    Get.snackbar("Success", "Login successful",
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstants.mainScaffoldBackgroundColor,
        backgroundColor: ColorConstants.snakbarColorsuccessful);
  }
}
