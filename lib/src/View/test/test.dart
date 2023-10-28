import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxString? userEmail = ''.obs;
  RxString? username = ''.obs;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> saveUserInfo() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    await SharedPreferencesHelper.saveUserInfo(username, email, password);
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final email = await SharedPreferencesHelper.getUserEmail();
    final name = await SharedPreferencesHelper.getUsername();
    userEmail!.value = email ?? '';
    username!.value = name ?? "";
  }

  Future<void> clearUserInfo() async {
    await SharedPreferencesHelper.clearUserInfo();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() => Column(
                children: [
                  Text('User Info:'),
                  Text('Username: ${username ?? "N/A"}'),
                  Text('Email: ${userEmail ?? "N/A"}'),
                ],
              )),
          SizedBox(height: 20),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: saveUserInfo,
                child: Text('Save User Info'),
              ),
              ElevatedButton(
                onPressed: clearUserInfo,
                child: Text('Clear User Info'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SharedPreferencesHelper {
  static Future<void> saveUserInfo(
      String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') != null;
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('password');
  }
}
