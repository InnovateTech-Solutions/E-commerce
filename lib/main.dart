import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:profile_part/firebase_options.dart';
import 'package:profile_part/src/View/start_pages/intro_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/constant/local_strings.dart';
import 'package:profile_part/src/getx/Searchpage_controller.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';

import 'src/repository/payment_reposiory/payment_manger.dart';
import 'src/repository/payment_reposiory/stripe_keys.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  Get.put(Appcontroller());
  Get.put(SearchPageController());
  Get.put(UserController());
  Get.put(PaymentManger());
  Stripe.publishableKey = ApiKeys.publishableKey;

  runApp(MyApp());
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
            locale: const Locale('en', 'US'),
            title: 'Icare',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: ColorConstants.mainScaffoldBackgroundColor),
            home: IntroPage());
      },
    );
  }
}
