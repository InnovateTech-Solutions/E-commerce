import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';

class OTPcontroller extends GetxController {
  static OTPcontroller get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);

    isVerified ? Get.offAll(const MainPage()) : Get.back();
  }
}
