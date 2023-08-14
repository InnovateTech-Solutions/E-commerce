import 'package:ecommerce/src/View/Forms/main_page.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/model/user_model.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:ecommerce/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  late UserModel user;
  final userRepository = Get.put(UserRepository);

  void registerUser(String email, String password) {
    AuthenticationRepository().createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await UserRepository().createUser(user);
    Get.to(const Testpage());
  }

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

  vaildateUserName(String? userName) {
    if (GetUtils.isUsername(userName!)) {
      return null;
    }
    return 'UserName is not vaild';
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!)) {
      return null;
    }
    return 'Phone Number is not vaild';
  }

  Future onSignup() async {
    if (fromkey.currentState!.validate()) {
      registerUser(email.text, password.text);
      createUser(user);
      Get.snackbar("Success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorsuccessful);
      return;
    } else {
      Get.snackbar("ERROR", "Email or Password is invild",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
  }

  void phoneAuthentication(String phoneNO) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNO);
  }
}
