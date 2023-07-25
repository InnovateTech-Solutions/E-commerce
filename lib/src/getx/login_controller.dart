import 'package:ecommerce/src/constant/color.dart';
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

  Future onLogin() async {
    if (formkey.currentState!.validate()) {
      Get.snackbar("Success", "Login successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorsuccessful);
      return;
    }
    Get.snackbar("Error", "Login unsuccessful",
        snackPosition: SnackPosition.BOTTOM,
        colorText: ColorConstants.mainScaffoldBackgroundColor,
        backgroundColor: ColorConstants.snakbarColorError);
  }
}
