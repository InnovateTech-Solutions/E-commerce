import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/test/test.dart';

class UserProfileWidget extends StatefulWidget {
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  String? username;
  String? userEmail;
  RxString? userinfoEmail = ''.obs;
  RxString userinfoUser = ''.obs;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final email = await SharedPreferencesHelper.getUserEmail();
    final username = await SharedPreferencesHelper.getUsername();
    setState(() {
      userEmail = email;
      this.username = username;
    });
  }

  Future<void> getUserInformation() async {
    final email = await SharedPreferencesHelper.getUserEmail();
    final username = await SharedPreferencesHelper.getUsername();
    userinfoEmail!.value = email ?? '';
    userinfoUser.value = username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('User Info:'),
        Text('Username: ${username ?? "N/A"}'),
        Text('Email: ${userEmail ?? "N/A"}'),
      ],
    );
  }
}
