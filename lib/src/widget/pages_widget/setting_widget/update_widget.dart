import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/user_actions/user_actions.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/transition/update_transition.dart';

import '../../../constant/app_const.dart';
import '../../../getx/profile_controller.dart';
import '../../../getx/register_controller.dart';
import '../../../model/login_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../custom_Widget.dart/button_widget.dart';
import '../../custom_Widget.dart/form_widget.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({Key? key}) : super(key: key);

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final usercontroller = Get.put(UserRepository());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final validator = Get.put(RegisterController());

    @override
    dispose() {
      super.dispose();
      controller.dispose();
      validator.dispose();
    }

    return FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 500),
          () => controller.getUserData(),
        ),
        builder: ((context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;
              final id = TextEditingController(text: userData.id);
              final email = TextEditingController(text: userData.email);
              final userName = TextEditingController(text: userData.name);
              final phoneNumber = TextEditingController(text: userData.phone);
              final password = TextEditingController(text: userData.password);

              return Form(
                  key: controller.fromkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagepicker(),
                      mainText(userName.text),
                      SizedBox(
                        height: 650.h,
                        width: double.infinity,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 30.h),
                          children: [
                            textFieldLabel(AppConst.email),
                            FormWidget(
                                login: Login(
                                    enableText: true,
                                    controller: email,
                                    hintText: 'Email',
                                    icon: const Icon(Icons.email_rounded),
                                    invisible: false,
                                    validator: (email) =>
                                        validator.validateEmail(email),
                                    type: TextInputType.emailAddress,
                                    onChange: null,
                                    inputFormat: [])),
                            AppSizes.smallHeightSizedBox,
                            textFieldLabel(AppConst.username),
                            FormWidget(
                                login: Login(
                                    enableText: false,
                                    controller: userName,
                                    hintText: 'Username',
                                    icon: const Icon(Icons.person),
                                    invisible: false,
                                    validator: (userName) =>
                                        validator.vaildateUserName(userName),
                                    type: TextInputType.name,
                                    onChange: null,
                                    inputFormat: [])),
                            AppSizes.smallHeightSizedBox,
                            textFieldLabel(AppConst.phoneNumber),
                            FormWidget(
                                login: Login(
                                    enableText: false,
                                    controller: phoneNumber,
                                    hintText: 'Phone Number',
                                    icon: const Icon(Icons.phone),
                                    invisible: false,
                                    validator: (phoneNumber) =>
                                        validator.vaildPhoneNumber(phoneNumber),
                                    type: TextInputType.number,
                                    onChange: null,
                                    inputFormat: [])),
                            AppSizes.mediumHeightSizedBox,
                            ButtonWidget(
                                onTap: () async {
                                  if ((controller.fromkey.currentState!
                                      .validate())) {
                                    final userData = UserModel(
                                        id: id.text.trim(),
                                        email: email.text.trim(),
                                        name: userName.text.trim(),
                                        password: password.text.trim(),
                                        phone: phoneNumber.text.trim(),
                                        imageUrl: "");
                                    await controller.updateRecord(userData);
                                  }
                                  dispose();
                                },
                                tilte: 'UPDATE')
                          ],
                        ),
                      ),
                    ],
                  ));
            } else if (snapShot.hasError) {
              return Center(child: Text(snapShot.error.toString()));
            } else {
              return const Text("somthing went wrong");
            }
          } else if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: UpdateTransition());
          } else {
            return const Text("somthing went wrong");
          }
        }));
  }
}
