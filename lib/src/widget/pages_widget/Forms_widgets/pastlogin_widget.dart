import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/View/checkout/confirm_page.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/login_Controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/pastlogin_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partail/continue_login.dart';

class Pastloginwidget extends GetView<LoginController> {
  const Pastloginwidget(
      {required this.vendorModel,
      required this.confirmDate,
      required this.confirmTime,
      super.key});
  final VendorModel vendorModel;
  final String confirmDate;
  final String confirmTime;
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final _authcontroller = Get.put(AuthenticationRepository());
    final _usercontroller = Get.put(UserController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
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
              Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.r,
                                blurRadius: 3.r,
                                offset: const Offset(0, 2)),
                          ],
                        ),
                        child: FormWidget(
                            login: Login(
                          enableText: false,
                          controller: controller.email,
                          hintText: AppConst.email,
                          icon: const Icon(Icons.email),
                          invisible: false,
                          validator: (email) => controller.validateEmail(email),
                          type: TextInputType.emailAddress,
                          onChange: null,
                          inputFormat: null,
                        )),
                      ),
                      AppSizes.smallHeightSizedBox,
                      FormWidget(
                          login: Login(
                        enableText: false,
                        controller: controller.password,
                        hintText: AppConst.password,
                        icon: const Icon(Icons.lock),
                        invisible: false,
                        validator: (password) =>
                            controller.validateEmail(password),
                        type: TextInputType.visiblePassword,
                        onChange: null,
                        inputFormat: null,
                      )),
                      AppSizes.mediumHeightSizedBox,
                      onLoginContainer(
                          title: AppConst.login,
                          onTap: () => {
                                controller.onLogin,
                                _usercontroller.logIn(),
                                Get.to(ConfirmPage(
                                    vendorModel: vendorModel,
                                    confirmDate: confirmDate,
                                    confirmTime: confirmTime))
                              })
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
