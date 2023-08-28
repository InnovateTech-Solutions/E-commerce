import 'package:ecommerce/src/model/user_model.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:ecommerce/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final fromkey = GlobalKey<FormState>();
  final id = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  updateRecord(UserModel user) async {
    print(' User data : ${user.email}');
    await _userRepo.updateUserRecord(user);
  }
}
