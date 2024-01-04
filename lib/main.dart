import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:profile_part/firebase_options.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/constant/local_strings.dart';
import 'package:profile_part/src/getx/Searchpage_controller.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/getx/notifications_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'src/repository/payment_reposiory/payment_manger.dart';
import 'src/repository/payment_reposiory/stripe_keys.dart';

final notificationsController = Get.put(NotificationsController());
void main() async {
  // final notificationsController = Get.put(NotificationsController());
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
      

  await notificationsController.initializeNotification();
  notificationsController.requestIOSPermissions();
  // Initialize flutter_local_notifications
 
  await initNotifications();
   // Set up Firebase Cloud Messaging
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    
       Get.snackbar("Success", message.data.toString(),
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.mainScaffoldBackgroundColor,
            backgroundColor: ColorConstants.snakbarColorsuccessful);

    print("Foreground notification: ${message.data.toString()}");
    // Handle foreground notification
  });
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  //     .then((value) => Get.put(AuthenticationRepository()));
  //    print("Terminated notification: ${message.data.toString()}");
  //   String title = message.notification?.title ?? "";
  //   String body = message.notification?.body ?? "";
  //   await notificationsController.displayNotification(title: title, body: body);
  //   // Handle terminated notification
  // });
  
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
            home: MainPage());
      },
    );
  }
}
final _firebaseMessaging =FirebaseMessaging.instance;
//initializes fcm notifications
 Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    notificationsController.fcmToken = await _firebaseMessaging.getToken() ?? "";

  // final fcmToken = await _firebaseMessaging.getToken();

    print('token ${notificationsController.fcmToken}');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message){
    if(message == null) return;
     String title = message.notification?.title ?? "";
     String body = message.notification?.body ?? "";
     notificationsController.displayNotification(title: title, body: body); 
    print('handleMessage $message');

  }

  // Handle background notification
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 try {

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    String title = message.notification?.title ?? "";
    String body = message.notification?.body ?? "";
    await notificationsController.displayNotification(title: title, body: body);
    print("Background notification: ${message.data.toString()}");

  } catch (e) {
    print("Error initializing Firebase in background handler: $e");
  }
}
  //handle notification when the app is terminated
  Future initPushNotifications() async  {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  
