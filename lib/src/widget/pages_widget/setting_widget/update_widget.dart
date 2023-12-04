import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/helpers/actions/user_actions.dart';
import 'package:profile_part/src/transition/update_transition.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

import '../../../constant/app_const.dart';
import '../../../getx/profile_controller.dart';
import '../../../getx/register_controller.dart';
import '../../../model/login_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/user_repository/user_repository.dart';
import '../../Text_Widget/form_text.dart';
import '../../custom_Widget.dart/form_widget.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({Key? key}) : super(key: key);

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final usercontroller = Get.put(UserRepository());
  final controller = Get.put(ProfileController());
  final validator = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
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
              RxString usernameTitle = userName.text.obs;
              return Form(
                  key: controller.fromkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorConstants.mainTextColor,
                              ))
                        ],
                      ),
                      imagepicker(),
                      SizedBox(
                        height: 500.h,
                        width: double.infinity,
                        child: ListView(
                          physics: FixedExtentScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  inputFormat: [],
                                  onTap: () {}),
                              color: ColorConstants.mainScaffoldBackgroundColor,
                            ),
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
                                  inputFormat: [],
                                  onTap: () {}),
                              color: ColorConstants.mainScaffoldBackgroundColor,
                            ),
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
                                  inputFormat: [],
                                  onTap: () {}),
                              color: ColorConstants.mainScaffoldBackgroundColor,
                            ),
                            AppSizes.smallHeightSizedBox,
                            textFieldLabel(AppConst.gander),
                            Obx(
                              () => dropDown(),
                            ),
                            AppSizes.smallHeightSizedBox,
                            textFieldLabel(AppConst.age),
                            FormWidget(
                              login: Login(
                                enableText: true,
                                controller: validator.age,
                                hintText: AppConst.age,
                                icon: const Icon(Icons.person),
                                invisible: false,
                                validator: (age) => validator.validateAge(age),
                                type: TextInputType.datetime,
                                onChange: null,
                                inputFormat: null,
                                onTap: () {
                                  validator.selectDate(context);
                                },
                              ),
                              color: ColorConstants.mainScaffoldBackgroundColor,
                            ),
                            AppSizes.smallHeightSizedBox,
                            onLoginContainer(
                                onTap: () async {
                                  if ((controller.fromkey.currentState!
                                      .validate())) {
                                    final userData = UserModel(
                                        id: id.text.trim(),
                                        email: email.text.trim(),
                                        name: userName.text.trim(),
                                        password: password.text.trim(),
                                        phone: phoneNumber.text.trim(),
                                        imageUrl: "",
                                        age: "",
                                        gander: "");
                                    await controller.updateRecord(userData);
                                  }
                                  dispose();
                                  usernameTitle.value = userName.text.trim();
                                  print(usernameTitle.value);
                                },
                                title: 'UPDATE')
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
            return const UpdateTransition();
          } else {
            return const Text("somthing went wrong");
          }
        }));
  }

  dropDown() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.r,
              blurRadius: 3.r,
              offset: const Offset(0, 2)),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: ColorConstants.mainScaffoldBackgroundColor,
      ),
      child: DropdownButton<String>(
        hint: Text("Gender"),
        underline: Container(
          color: ColorConstants.mainScaffoldBackgroundColor,
        ),
        isExpanded: true,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.r),
        value: validator.selectedItem.value == ""
            ? null
            : validator.selectedItem.value,
        onChanged: (newValue) {
          validator.upDateSelectedItem(newValue.toString());
        },
        items: AppConst.dropDownList.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: textFieldLabel(
              value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
