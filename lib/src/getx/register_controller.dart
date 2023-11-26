import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profile_part/src/View/Forms/secregister_page.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController gander = TextEditingController();
  final TextEditingController age = TextEditingController();
  final firstFormkey = GlobalKey<FormState>();
  final secondFormkey = GlobalKey<FormState>();
  late UserModel user;
  final userRepository = Get.put(UserRepository);
  RxString selectedItem = "".obs;

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '### ### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void registerUser(String email, String password) {
    AuthenticationRepository().createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await UserRepository().createUser(user);
    Get.to(const MainPage());
  }

  validateEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return 'Email is not vaild';
  }

  validateAge(String? age) {
    if (age!.isNotEmpty) {
      return null;
    }
    return 'Date of Birth is not vaild';
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  validConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Please Re-Enter New Password";
    } else if (value != password.text) {
      return "Password must be same as above";
    } else {
      return null;
    }
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

  void upDateSelectedItem(String value) {
    selectedItem.value = value;
    gander.text = selectedItem.value;
  }

  Future<void> onSignup(UserModel user) async {
    if (secondFormkey.currentState!.validate() && gander.text != "") {
      bool usernameCheck = await isUsernameTaken(user.name);
      if (!usernameCheck) {
        Future<bool> code = AuthenticationRepository()
            .createUserWithEmailAndPassword(user.email, user.password);
        if (await code) {
          createUser(user);
          Get.snackbar("Success", " Account  Created Successfullly",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConstants.mainScaffoldBackgroundColor,
              backgroundColor: ColorConstants.snakbarColorsuccessful);
        } else {
          Get.snackbar("ERROR", "Invalid datas",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConstants.mainScaffoldBackgroundColor,
              backgroundColor: ColorConstants.snakbarColorError);
        }
      } else {
        Get.snackbar("ERROR", "Username  is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.mainScaffoldBackgroundColor,
            backgroundColor: ColorConstants.snakbarColorError);
      }
    }
  }

  Future<void> secondScreenNavigate() async {
    if (firstFormkey.currentState!.validate()) {
      Get.to(SecRegisterPage());
    } else {
      Get.snackbar("ERROR", "Invalid Data",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
  }

  var dateInput = "".obs;

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorConstants.secondaryScaffoldBacground,
            colorScheme:
                ColorScheme.light(primary: ColorConstants.mainTextColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateInput.value = formattedDate;
      age.text = dateInput.value;
      print(age.text);
    }
  }
}
