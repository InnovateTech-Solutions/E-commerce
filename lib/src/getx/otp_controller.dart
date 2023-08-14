import 'package:ecommerce/src/View/Forms/main_page.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:get/get.dart';

class OTPcontroller extends GetxController {
  static OTPcontroller get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);

    isVerified ? Get.offAll(const Testpage()) : Get.back();
  }
}
