import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();
  //create an instance of firebase_messaging
    final _firebaseMessaging =FirebaseMessaging.instance;
  
  
  // function to initialize notifications

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('token $fcmToken');
  }

  //function to handle recieved messages

  //function to initialize foreground and background settings

}
