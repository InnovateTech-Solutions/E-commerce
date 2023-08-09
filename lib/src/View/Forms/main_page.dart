import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';

class Testpage extends StatelessWidget {
  const Testpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: ElevatedButton(
            onPressed: () => AuthenticationRepository().logout(),
            child: const Text('log out')),
      ),
    );
  }
}
