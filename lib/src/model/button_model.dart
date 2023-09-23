import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Button {
  late SvgPicture icon;
  late String title;
  late VoidCallback onTap;

  Button({required this.title, required this.icon, required this.onTap});
}

class DrawerButt {
  late Icon icon;
  late String title;
  late VoidCallback onTap;

  DrawerButt({required this.title, required this.icon, required this.onTap});
}
