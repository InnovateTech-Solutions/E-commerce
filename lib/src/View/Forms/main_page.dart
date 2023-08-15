import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

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
