import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:get/get.dart';

class MailVerification extends GetxController {
  @override
  void onInit() {
    super.onInit();
    sendVerification();
  }

  void sendVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
