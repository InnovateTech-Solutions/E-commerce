import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/user_model.dart';

class UserInfo extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Getx SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => userController.isLoggedIn.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Obx(() => Text('Username: ${userController.username.value}')),
                  Obx(() => Text('Email: ${userController.email.value}')),
                  Obx(() => Text('Email: ${userController.phone.value}')),
                  Obx(() =>
                      Text('islogeedin: ${userController.isLoggedIn.value}')),
                  Obx(() =>
                      Text('Email: ${userController.notification.value}')),
                  Obx(() => Text('IS TOGGLE: ${userController.isSwitched}')),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          userController.saveUserInfo(UserModel(
                              email: emailController.text,
                              name: usernameController.text,
                              password: 'password',
                              phone: 'phone',
                              imageUrl: 'imageUrl'));
                        },
                        child: Text('Save User Info'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          userController.clearUserInfo();
                        },
                        child: Text('Clear User Info'),
                      ),
                    ],
                  ),
                ],
              )
            : Container(
                child: Column(
                  children: [
                    Obx(() =>
                        Text('Username: ${userController.username.value}')),
                    Obx(() => Text('Email: ${userController.email.value}')),
                    Obx(() => Text('Email: ${userController.phone.value}')),
                    Obx(() =>
                        Text('Email: ${userController.isLoggedIn.value}')),
                    Obx(() =>
                        Text('Email: ${userController.notification.value}')),
                  ],
                ),
              )),
      ),
    );
  }
}

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    Future otpFunction() async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+962 787781174',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }

    Future testOtp() async {
      FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
      ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber('+962 7877 81174');
      UserCredential userCredential =
          await confirmationResult.confirm('123456');
    }

    return Column(
      children: [
        ElevatedButton(onPressed: () => testOtp(), child: Text('data'))
      ],
    );
  }
}
*/