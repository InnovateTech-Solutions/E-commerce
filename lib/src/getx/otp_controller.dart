import 'package:get/get.dart';

class OTPcontroller extends GetxController {
  static OTPcontroller get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);

    isVerified ? Get.offAll(const Testpage()) : Get.back();
  }
}
