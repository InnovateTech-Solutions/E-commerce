import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Profile {
  late SvgPicture icon;
  late String title;
  late VoidCallback onTap;

  Profile({required this.title, required this.icon, required this.onTap});
}
