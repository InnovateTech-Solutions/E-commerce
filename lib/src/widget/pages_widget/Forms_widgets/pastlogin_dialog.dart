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
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

final _authcontroller = Get.put(AuthenticationRepository());
final _usercontroller = Get.put(UserController());
final controller = Get.put(LoginController());
void pastLoginDialoge(String confirmTime, String confirmDate,
    VendorModel vendorModel, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r))),
    builder: (
      context,
    ) {
      return Container(
        margin: EdgeInsets.all(10),
        height: 500.h,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                        FormWidget(
                          login: Login(
                            enableText: false,
                            controller: controller.email,
                            hintText: AppConst.email,
                            icon: const Icon(Icons.email),
                            invisible: false,
                            validator: (email) =>
                                controller.validateEmail(email),
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
                            controller: controller.password,
                            hintText: AppConst.password,
                            icon: const Icon(Icons.lock),
                            invisible: false,
                            validator: (password) =>
                                controller.vaildatePassword(password),
                            type: TextInputType.visiblePassword,
                            onChange: null,
                            inputFormat: null,
                            onTap: () {},
                          ),
                          color: ColorConstants.mainScaffoldBackgroundColor,
                        ),
                        AppSizes.mediumHeightSizedBox,
                        ElevatedButton(
                            onPressed: () {
                              controller.onLogin;
                              _usercontroller.logIn();
                              Get.to(ConfirmPage(
                                  vendorModel: vendorModel,
                                  confirmDate: confirmDate,
                                  confirmTime: confirmTime));
                            },
                            child: Text("ss")),
                        onLoginContainer(
                            title: AppConst.login,
                            onTap: () {
                              print("object");
                              controller.onLogin;
                              _usercontroller.logIn();
                              Get.to(ConfirmPage(
                                  vendorModel: vendorModel,
                                  confirmDate: confirmDate,
                                  confirmTime: confirmTime));
                            })
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}
