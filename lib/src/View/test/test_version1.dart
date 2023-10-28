import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    email.value = prefs.getString('email') ?? '';
    phone.value = prefs.getString('phone') ?? '';
  }

  Future<void> saveUserInfo(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phone);
    username.value = user.name;
    email.value = user.email;
    phone.value = user.phone;
  }

  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    username.value = '';
    email.value = '';
  }
}

class UserInfo extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text('Username: ${userController.username.value}')),
            Obx(() => Text('Email: ${userController.email.value}')),
            Obx(() => Text('Email: ${userController.phone.value}')),
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
        ),
      ),
    );
  }
}
