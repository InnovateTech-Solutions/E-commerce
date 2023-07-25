import 'package:ecommerce/src/Forms/login_page.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
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
