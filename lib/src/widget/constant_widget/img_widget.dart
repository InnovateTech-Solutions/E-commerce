import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/user_repository/user_repository.dart';

class Img extends StatelessWidget {
  const Img({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserRepository());

    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {},
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 50,
            );
          },
          itemCount: userController.allImg.length),
    );
  }
}
