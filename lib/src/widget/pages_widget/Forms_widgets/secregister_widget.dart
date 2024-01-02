// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:profile_part/src/constant/app_const.dart';
// import 'package:profile_part/src/constant/color.dart';
// import 'package:profile_part/src/getx/user_controller.dart';
// import 'package:profile_part/src/model/login_model.dart';
// import 'package:profile_part/src/model/user_model.dart';
// import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
// import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
// import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
// import 'package:profile_part/src/widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';

// import '../../../getx/register_controller.dart';
// import '../../partial_widget/forms_partial.dart/login_external.dart';

// class SecRegisterWidget extends StatefulWidget {
//   const SecRegisterWidget({super.key});

//   @override
//   State<SecRegisterWidget> createState() => _SecRegisterWidgetState();
// }

// class _SecRegisterWidgetState extends State<SecRegisterWidget> {
//   final controller = Get.put(RegisterController());
//   final userController = Get.put(UserController());
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Column(
//         children: [
//           Center(
//             child: Form(
//                 key: controller.secondFormkey,
//                 child: SizedBox(
//                   height: 520.h,
//                   width: 320.w,
//                   child: ListView(
//                     children: [
//                       mainText("Register Your Account"),
//                       AppSizes.smallHeightSizedBox,
//                       textFieldLabel(AppConst.phoneNumber),
//                       FormWidget(
//                         login: Login(
//                           enableText: false,
//                           controller: controller.phoneNumber,
//                           hintText: AppConst.phoneNumber,
//                           icon: const Icon(Icons.phone),
//                           invisible: false,
//                           validator: (email) =>
//                               controller.vaildPhoneNumber(email),
//                           type: TextInputType.number,
//                           onChange: null,
//                           inputFormat: [controller.maskFormatterPhone],
//                           onTap: () {},
//                         ),
//                         color: ColorConstants.mainScaffoldBackgroundColor,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2.r,
//                                 blurRadius: 10.r,
//                                 offset: const Offset(0, 2)),
//                           ],
//                         ),
//                         child: onLoginContainer(
//                             onTap: () => {
//                                   print(controller.gander.text),
//                                   controller.onSignup(UserModel(
//                                     email: controller.email.text.trim(),
//                                     name: controller.userName.text.trim(),
//                                     password: controller.password.text.trim(),
//                                     phone: controller.phoneNumber.text.trim(),
//                                     imageUrl: '',
//                                   )),
//                                   userController.saveUserInfo(UserModel(
//                                     email: controller.email.text.trim(),
//                                     name: controller.userName.text.trim(),
//                                     password: controller.password.text.trim(),
//                                     phone: controller.phoneNumber.text.trim(),
//                                     imageUrl: '',
//                                   ))
//                                 },
//                             title: AppConst.signUp),
//                       ),
//                     ],
//                   ),
//                 )),
//           ),
//           LoginExternal(),
//         ],
//       ),
//     );
//   }
// }
