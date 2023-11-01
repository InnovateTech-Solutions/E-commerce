import 'package:flutter/material.dart';

class AppDrawerButton {
  late Icon icon;
  late String title;
  late VoidCallback onTap;

  AppDrawerButton(
      {required this.title, required this.icon, required this.onTap});
}
