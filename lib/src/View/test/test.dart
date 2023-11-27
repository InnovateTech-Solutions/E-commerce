// /*import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TestCheck extends StatefulWidget {
//   @override
//   _TestCheckState createState() => _TestCheckState();
// }

// class _TestCheckState extends State<TestCheck> {
//   final TextEditingController _emailController = TextEditingController();
//   bool emailExists = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Checker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Email',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 String enteredEmail = _emailController.text.trim();
//                 emailExists = await checkEmailExists(enteredEmail);

//                 if (emailExists) {
//                   print('$enteredEmail exists in the collection.');
//                 } else {
//                   print('$enteredEmail does not exist. Creating an account.');
//                   // Add your account creation logic here
//                 }
//               },
//               child: Text('Check Email'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool> checkEmailExists(String email) async {
//     bool exists = false;

//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('User') // Replace with your actual collection name
//           .where('Email', isEqualTo: email)
//           .get();

//       exists = querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       // Handle any errors that might occur.
//       print('Error checking email existence: $e');
//     }

//     return exists;
//   }
// }

// class ContentView extends StatelessWidget {
//   const ContentView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final shouldPop = await showDialog<bool>(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Do you want to go back?'),
//               actionsAlignment: MainAxisAlignment.spaceBetween,
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                   },
//                   child: const Text('Yes'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                   },
//                   child: const Text('No'),
//                 ),
//               ],
//             );
//           },
//         );
//         return shouldPop!;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Content View'),
//         ),/
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: const [
//               Text(
//                 'This is the Content View',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// */ /*
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:profile_part/src/constant/color.dart';
// import 'package:profile_part/src/getx/user_controller.dart';
// import 'package:profile_part/src/widget/Text_Widget/pastlogin_text.dart';
// import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

// import '../../constant/app_const.dart';
// import '../../getx/login_Controller.dart';
// import '../../model/login_model.dart';
// import '../../model/vendor_model.dart';
// import '../../repository/authentication/authentication_repository.dart';
// import '../../widget/constant_widget/sizes/sized_box.dart';
// import '../../widget/partial_widget/forms_partial.dart/pastLogin_partial/continue_login.dart';
// import '../checkout/confirm_page.dart';

// final _authcontroller = Get.put(AuthenticationRepository());
// final _usercontroller = Get.put(UserController());
// final controller = Get.put(LoginController());
// void pastLoginDialoge(String confirmTime, String confirmDate,
//     VendorModel vendorModel, BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierLabel: "",
//     barrierDismissible: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: Duration(milliseconds: 700),
//     pageBuilder: (
//       context,
//       anim1,
//       anim2,
//     ) {
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           width: double.infinity.w,
//           height: 500.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             color: ColorConstants.mainScaffoldBackgroundColor,
//           ),
//           child: Scaffold(
//             body: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     mainPastLoginText(AppConst.pastlogin),
//                     AppSizes.smallHeightSizedBox,
//                     secondaryPastLoginText(AppConst.pastloginText),
//                     AppSizes.smallHeightSizedBox,
//                     continueContainer(
//                         title: AppConst.googleContainerText,
//                         imgname: AppConst.googleimg,
//                         callback: _authcontroller.signInWithGoogle),
//                     AppSizes.smallHeightSizedBox,
//                     continueContainer(
//                         title: AppConst.appleCotanierText,
//                         imgname: AppConst.appleimg,
//                         callback: () => _authcontroller.signInWithGoogle),
//                     AppSizes.smallHeightSizedBox,
//                     AppConst.pageDivider,
//                     AppSizes.smallHeightSizedBox,
//                     Form(
//                         key: controller.formkey,
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.r)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2.r,
//                                       blurRadius: 3.r,
//                                       offset: const Offset(0, 2)),
//                                 ],
//                               ),
//                               child: FormWidget(
//                                 login: Login(
//                                   enableText: false,
//                                   controller: controller.email,
//                                   hintText: AppConst.email,
//                                   icon: const Icon(Icons.email),
//                                   invisible: false,
//                                   validator: (email) =>
//                                       controller.validateEmail(email),
//                                   type: TextInputType.emailAddress,
//                                   onChange: null,
//                                   inputFormat: null,
//                                 ),
//                                 color:
//                                     ColorConstants.mainScaffoldBackgroundColor,
//                               ),
//                             ),
//                             AppSizes.smallHeightSizedBox,
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.r)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2.r,
//                                       blurRadius: 3.r,
//                                       offset: const Offset(0, 2)),
//                                 ],
//                               ),
//                               child: FormWidget(
//                                 login: Login(
//                                   enableText: false,
//                                   controller: controller.password,
//                                   hintText: AppConst.password,
//                                   icon: const Icon(Icons.lock),
//                                   invisible: false,
//                                   validator: (password) =>
//                                       controller.validateEmail(password),
//                                   type: TextInputType.visiblePassword,
//                                   onChange: null,
//                                   inputFormat: null,
//                                 ),
//                                 color:
//                                     ColorConstants.mainScaffoldBackgroundColor,
//                               ),
//                             ),
//                             AppSizes.mediumHeightSizedBox,
//                             onLoginContainer(
//                                 title: AppConst.login,
//                                 onTap: () => {
//                                       controller.onLogin,
//                                       _usercontroller.logIn(),
//                                       Get.to(ConfirmPage(
//                                           vendorModel: vendorModel,
//                                           confirmDate: confirmDate,
//                                           confirmTime: confirmTime))
//                                     })
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return SlideTransition(
//         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
//         child: child,
//       );
//     },
//   );
// }
// */import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _location = 'Fetching location...';

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       setState(() {
//         _location =
//             'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//       });
//     } catch (e) {
//       print(e);
//       setState(() {
//         _location = 'Error fetching location';
//       });
//     }
//   }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorTest extends StatefulWidget {
  @override
  _GeolocatorTestState createState() => _GeolocatorTestState();
}

class _GeolocatorTestState extends State<GeolocatorTest> {
  String? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                determinePosition().then((result) {
                  setState(() {
                    location = result;
                  });
                }).catchError((error) {
                  setState(() {
                    location = 'Error: $error';
                  });
                });
              },
              child: Text('Get Location'),
            ),
            SizedBox(height: 20),
            Text(
              'Location: ${location ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();

    // Convert the position to a string
    String locationString =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';

    // Return the location string
    return locationString;
  }
}
