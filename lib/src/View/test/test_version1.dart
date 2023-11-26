// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:profile_part/src/constant/color.dart';
// import 'package:profile_part/src/getx/data_controller.dart';
// import 'package:profile_part/src/getx/user_controller.dart';
// import 'package:profile_part/src/getx/vendors_controller.dart';
// import 'package:profile_part/src/model/booking_model.dart';
// import 'package:profile_part/src/model/user_model.dart';
// import 'package:profile_part/src/model/vendor_model.dart';
// import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
// import 'package:profile_part/src/repository/user_repository/user_repository.dart';
// import 'package:profile_part/src/widget/Text_Widget/confirm_text.dart';
// import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
// import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
// import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

// class UserInfo extends StatelessWidget {
//   final UserController userController = Get.put(UserController());
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Getx SharedPreferences Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() => userController.isLoggedIn.value
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Obx(() => Text('Username: ${userController.username.value}')),
//                   Obx(() => Text('Email: ${userController.email.value}')),
//                   Obx(() => Text('Email: ${userController.phone.value}')),
//                   Obx(() =>
//                       Text('islogeedin: ${userController.isLoggedIn.value}')),
//                   Obx(() => Text('Email: ${userController.notification}')),
//                   Obx(() => Text('IS TOGGLE: ${userController.isSwitched}')),
//                   TextField(
//                     controller: usernameController,
//                     decoration: InputDecoration(labelText: 'Username'),
//                   ),
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: () {
//                           userController.saveUserInfo(UserModel(
//                               email: emailController.text,
//                               name: usernameController.text,
//                               password: 'password',
//                               phone: 'phone',
//                               imageUrl: 'imageUrl'));
//                         },
//                         child: Text('Save User Info'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           userController.clearUserInfo();
//                         },
//                         child: Text('Clear User Info'),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             : Container(
//                 child: Column(
//                   children: [
//                     Obx(() =>
//                         Text('Username: ${userController.username.value}')),
//                     Obx(() => Text('Email: ${userController.email.value}')),
//                     Obx(() => Text('Email: ${userController.phone.value}')),
//                     Obx(() =>
//                         Text('Email: ${userController.isLoggedIn.value}')),
//                     Obx(() =>
//                         Text('Email: ${userController.notification.value}')),
//                     Obx(() =>
//                         Text('Email: ${userController.notification.value}')),
//                   ],
//                 ),
//               )),
//       ),
//     );
//   }
// }

// /// Flutter code sample for [PageView].

// class PageViewExampleApp extends StatelessWidget {
//   const PageViewExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('PageView Sample')),
//         body: const PageViewExample(),
//       ),
//     );
//   }
// }

// class PageViewExample extends StatelessWidget {
//   const PageViewExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PageController controller = PageController();
//     return PageView(
//       /// [PageView.scrollDirection] defaults to [Axis.horizontal].
//       /// Use [Axis.vertical] to scroll vertically.
//       ///
//       ///
//       ///

//       controller: controller,
//       children: const <Widget>[
//         Center(
//           child: Text('First Page'),
//         ),
//         Center(
//           child: Text('Second Page'),
//         ),
//         Center(
//           child: Text('Third Page'),
//         ),
//       ],
//     );
//   }
// }

// class SimmlirCategory extends StatefulWidget {
//   const SimmlirCategory({super.key});

//   @override
//   State<SimmlirCategory> createState() => _SimmlirCategoryState();
// }

// class _SimmlirCategoryState extends State<SimmlirCategory> {
//   @override
//   Widget build(BuildContext context) {
//     final datacontroller = Get.put(DataController());
//     return Scaffold(
//       backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FutureBuilder<List<VendorModel>>(
//               future: datacontroller.fetchCategoriesByVendor('Skin care'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasData) {
//                     final similarItem = snapshot.data!;
//                     similarItem.shuffle();
//                     return similarItem.isEmpty
//                         ? Text('data')
//                         : Column(
//                             children: [
//                               SizedBox(
//                                   height: 200,
//                                   child: ListView.builder(
//                                       itemCount: similarItem.length,
//                                       itemBuilder: (context, index) {
//                                         return Text(
//                                           similarItem[index].name,
//                                           style: TextStyle(color: Colors.red),
//                                         );
//                                       }))
//                             ],
//                           );
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   } else {
//                     return Text('Somthing wrong');
//                   }
//                 } else if (snapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Text('Somthing wrong');
//                 }
//               })
//         ],
//       ),
//     );
//   }
// }

// class YourWidget extends StatefulWidget {
//   @override
//   State<YourWidget> createState() => _YourWidgetState();
// }

// class _YourWidgetState extends State<YourWidget> {
//   final VendorController vendorController = Get.put(VendorController('Spa'));
//   String name = 'dental clinic';
//   @override
//   void initState() {
//     super.initState();
//     vendorController.fetchVendorsByCategory(name);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Column(
//         children: [
//           Obx(() {
//             if (vendorController.vendors.isEmpty) {
//               return CircularProgressIndicator(); // Show a loading indicator while data is loading.
//             } else {
//               return SizedBox(
//                 height: 205,
//                 width: 400,
//                 child: ListView.separated(
//                   separatorBuilder: (context, index) {
//                     return AppSizes.smallWidthSizedBox;
//                   },
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: vendorController.vendors.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 350.w,
//                       height: 200.h,
//                       decoration: BoxDecoration(
//                         color: ColorConstants.mainScaffoldBackgroundColor,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2.r,
//                               blurRadius: 2.r,
//                               offset: const Offset(0, 2))
//                         ],
//                         borderRadius: BorderRadius.circular(10.0.r),
//                       ),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                                 width: 350.w,
//                                 height: 100.h,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7.0.r),
//                                   image: DecorationImage(
//                                       image: NetworkImage(vendorController
//                                           .vendors[index].image),
//                                       fit: BoxFit.cover),
//                                 )),
//                             AppSizes.xsmallHeightSizedBox,
//                             subvendorText(vendorController.vendors[index].name),
//                             Obx(() => vendorController
//                                         .vendors[index].averageRating
//                                         .toString() ==
//                                     'null'
//                                 ? Container()
//                                 : Row(
//                                     children: [
//                                       secondaryConfirmText(
//                                         vendorController
//                                             .vendors[index].averageRating
//                                             .toString(),
//                                       ),
//                                       Icon(
//                                         Icons.star,
//                                         color: Colors.yellow,
//                                         size: 15,
//                                       )
//                                     ],
//                                   )),
//                             AppSizes.xsmallHeightSizedBox,
//                             thirdConfirmText(
//                                 vendorController.vendors[index].address),
//                           ]),
//                     );
//                   },
//                 ),
//               );
//             }
//           }),
//         ],
//       ),
//     );
//   }
// }

// class HorizontalListView extends StatelessWidget {
//   final List<String> itemTitles = ['Item 1', 'Item 2', 'Item 3'];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: itemTitles.length,
//       itemBuilder: (context, index) {
//         return Container(
//           width: 150.0,
//           color: Colors.accents[index % Colors.accents.length],
//           child: Center(child: Text(itemTitles[index])),
//         );
//       },
//     );
//   }
// }




// /*
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class UserInfo extends StatefulWidget {
//   const UserInfo({super.key});

//   @override
//   State<UserInfo> createState() => _UserInfoState();
// }

// class _UserInfoState extends State<UserInfo> {
//   @override
//   Widget build(BuildContext context) {
//     Future otpFunction() async {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '+962 787781174',
//         verificationCompleted: (PhoneAuthCredential credential) {},
//         verificationFailed: (FirebaseAuthException e) {},
//         codeSent: (String verificationId, int? resendToken) {},
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     }

//     Future testOtp() async {
//       FirebaseAuth auth = FirebaseAuth.instance;

// // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
//       ConfirmationResult confirmationResult =
//           await auth.signInWithPhoneNumber('+962 7877 81174');
//       UserCredential userCredential =
//           await confirmationResult.confirm('123456');
//     }

//     return Column(
//       children: [
//         ElevatedButton(onPressed: () => testOtp(), child: Text('data'))
//       ],
//     );
//   }
// }
// */