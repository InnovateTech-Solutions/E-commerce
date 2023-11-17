import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/login_model.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({required this.login, Key? key, required this.color})
      : super(key: key);
  Login login;
  Color color;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context)
            .copyWith(inputDecorationTheme: InputDecorationTheme()),
        child: TextFormField(
            readOnly: widget.login.enableText,
            inputFormatters: widget.login.inputFormat,
            keyboardType: widget.login.type,
            onChanged: widget.login.onChange,
            validator: widget.login.validator,
            obscureText: widget.login.invisible,
            controller: widget.login.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.color,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.secondaryScaffoldBacground),
                  borderRadius: BorderRadius.all(Radius.circular(7.r))),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.secondaryScaffoldBacground),
                  borderRadius: BorderRadius.all(Radius.circular(7.r))),
              hintText: widget.login.hintText,
            )),
      ),
    );
  }
}
