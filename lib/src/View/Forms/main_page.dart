import 'package:ecommerce/src/View/Forms/update_profile.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Testpage extends StatelessWidget {
  const Testpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () => Get.to(UpdateProfile()),
                child: const Text('log out')),
          ),
          ElevatedButton(
              onPressed: () => AuthenticationRepository().logout(),
              child: const Text('log out')),
        ],
      ),
    );
  }
}
