import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({required this.login, Key? key}) : super(key: key);
  Login login;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  void dispose() {
    widget.login.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: ColorConstants.textFiledmColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: TextFormField(
            inputFormatters: widget.login.inputFormat,
            keyboardType: widget.login.type,
            onChanged: widget.login.onChange,
            validator: widget.login.validator,
            obscureText: widget.login.invisible,
            controller: widget.login.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.login.hintText,
              prefixIcon: widget.login.icon,
            )),
      ),
    );
  }
}
