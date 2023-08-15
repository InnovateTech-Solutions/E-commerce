import 'package:ecommerce/src/repository/Forget_Password/forget_password.dart';
import 'package:get/get.dart';

class ForgetPasswordcontroller extends GetxController {
  static ForgetPasswordcontroller get instance => Get.find();

  passwordRest(context, email) {
    ForgetPasswordRepository().passwordReset(context, email);
  }
}
