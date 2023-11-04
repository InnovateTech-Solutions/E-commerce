import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/user_controller.dart';

class ToggleSwitchExample extends StatelessWidget {
  final toggleController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Switch(
        value: toggleController.isSwitched.value,
        onChanged: (value) {
          toggleController.saveSwitchState(value);
        },
      ),
    );
  }
}
