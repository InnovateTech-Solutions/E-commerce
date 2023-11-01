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
