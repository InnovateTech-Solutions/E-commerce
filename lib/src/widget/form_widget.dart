import 'package:ecommerce/src/model/login_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({required this.login, Key? key}) : super(key: key);
  Login login;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
          inputFormatters: widget.login.inputFormat,
          keyboardType: widget.login.type,
          onChanged: widget.login.onChange,
          validator: widget.login.validator,
          obscureText: widget.login.invisible,
          controller: widget.login.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.login.hintText,
            prefixIcon: widget.login.icon,
          )),
    );
  }
}
