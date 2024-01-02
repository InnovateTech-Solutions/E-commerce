import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/login_Controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/pastlogin_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

class PastLoginWidget extends StatelessWidget {
  const PastLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logController = Get.put(LoginController());
    final _authcontroller = Get.put(AuthenticationRepository());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainPastLoginText(AppConst.pastlogin),
                AppSizes.smallHeightSizedBox,
                secondaryPastLoginText(AppConst.pastloginText),
                AppSizes.smallHeightSizedBox,
                continueContainer(
                    title: AppConst.googleContainerText,
                    imgname: AppConst.googleimg,
                    callback: _authcontroller.signInWithGoogle),
                AppSizes.smallHeightSizedBox,
                continueContainer(
                    title: AppConst.appleCotanierText,
                    imgname: AppConst.appleimg,
                    callback: () => _authcontroller.signInWithGoogle),
                AppSizes.smallHeightSizedBox,
                AppConst.pageDivider,
                AppSizes.smallHeightSizedBox,
              ],
            ),
          ),
          Form(
              key: logController.formkey,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    FormWidget(
                      login: Login(
                        enableText: false,
                        controller: logController.email,
                        hintText: AppConst.email,
                        icon: const Icon(Icons.email),
                        invisible: false,
                        validator: (email) =>
                            logController.validateEmail(email),
                        type: TextInputType.emailAddress,
                        onChange: null,
                        inputFormat: null,
                        onTap: () {},
                      ),
                      color: ColorConstants.mainScaffoldBackgroundColor,
                    ),
                    AppSizes.smallHeightSizedBox,
                    FormWidget(
                      login: Login(
                        enableText: false,
                        controller: logController.password,
                        hintText: AppConst.password,
                        icon: const Icon(Icons.lock),
                        invisible: true,
                        validator: (password) =>
                            logController.vaildatePassword(password),
                        type: TextInputType.visiblePassword,
                        onChange: null,
                        inputFormat: null,
                        onTap: () {},
                      ),
                      color: ColorConstants.mainScaffoldBackgroundColor,
                    ),
                    AppSizes.mediumHeightSizedBox,
                    onLoginContainer(
                        title: AppConst.login,
                        onTap: () => {logController.onLogin()}),
                    dontHaveAccountRow(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
