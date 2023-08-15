import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/constant/local_strings.dart';
import 'package:ecommerce/src/repository/authentication/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: LocalStrings(),
          locale: Locale('en', 'US'),
          title: 'E-commerce',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: ColorConstants.mainScaffoldBackgroundColor),
          home: const LoginPage(),
        );
      },
    );
  }
}
