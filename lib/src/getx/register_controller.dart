import 'package:cloud_firestore/cloud_firestore.dart';
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


Future<bool> isUsernameTaken(String username) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  	    QuerySnapshot querySnapshot = await firestore
        .collection('User') 
        .where('UserName', isEqualTo: username)
        .get();
    return querySnapshot.docs.isNotEmpty;
  } catch (error) {
     Get.snackbar("Error", "Error checking username: $error",
                snackPosition: SnackPosition.BOTTOM,
                colorText: ColorConstants.mainScaffoldBackgroundColor,
                backgroundColor: ColorConstants.snakbarColorError);
    return false; 
  }
}


  Future<void> onSignup(UserModel user) async {
    if (fromkey.currentState!.validate()) {
    bool usernameCheck = await isUsernameTaken(user.name);
      if(!usernameCheck){

        Future<bool> code = AuthenticationRepository().createUserWithEmailAndPassword(user.email, user.password);
          if(await code){
            createUser(user);
            Get.snackbar("Success", " Account  Created Successfullly",
                snackPosition: SnackPosition.BOTTOM,
                colorText: ColorConstants.mainScaffoldBackgroundColor,
                backgroundColor: ColorConstants.snakbarColorsuccessful);
          }
    }
      else {
      Get.snackbar("ERROR", "Username  is taken",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
      
    } 
  }

  




}
