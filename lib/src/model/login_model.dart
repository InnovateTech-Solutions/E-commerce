import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Login {
  TextEditingController controller = TextEditingController();
  String hintText;
  Icon icon;
  bool invisible;
  bool enable;

  final String? Function(String?)? validator;
  TextInputType type;
  void Function(String?)? onChange;
  List<TextInputFormatter>? inputFormat;
  Login(
      {required this.controller,
      required this.enable,
      required this.hintText,
      required this.icon,
      required this.invisible,
      required this.validator,
      required this.type,
      required this.onChange,
      required this.inputFormat});
}
