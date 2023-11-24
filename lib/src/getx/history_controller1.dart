import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/booking_model.dart';

class HistoryController extends GetxController {
  static HistoryController get instance => Get.find();
  RxList<Booking> allApointment = <Booking>[].obs;
  RxList<Booking> todayAppointment = <Booking>[].obs;
  RxList<Booking> upcomingAppointment = <Booking>[].obs;
  late StreamSubscription<QuerySnapshot> subscription;
  RxString imageName = ''.obs;
  List<DocumentSnapshot> snapshots = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFutureBookings('abood.al7amed@gmail.com');
  }

  Future<void> getFutureBookings(String userId) async {
    DateTime now = DateTime.now();

    final bookingsCollection = await FirebaseFirestore.instance
        .collection('Bookings')
        .where('userEmail', isEqualTo: userId);

    subscription = bookingsCollection
        .where('date', isGreaterThan: now.toLocal().toString().split(' ')[0])
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      snapshots = querySnapshot.docs;
    });
  }

  Future<void> getImageName(String vendorName) async {
    try {
      CollectionReference vendors =
          FirebaseFirestore.instance.collection('Vendors');

      QuerySnapshot querySnapshot =
          await vendors.where('Name', isEqualTo: vendorName).get();

      if (querySnapshot.docs.isNotEmpty) {
        String imgName = querySnapshot.docs.first.get('Image');
        imageName.value = imgName;
      } else {
        imageName.value = '';
      }
    } catch (e) {
      print('Error getting image name: $e');
      imageName.value = '';
    }
  }
}

class UpBookingController extends GetxController {
  final RxList<DocumentSnapshot> snapshots = RxList<DocumentSnapshot>([]);
  late StreamSubscription<QuerySnapshot> subscription;

  Future<void> getFutureBookings(String userEmail) async {
    DateTime now = DateTime.now();

    final bookingsCollection =
        await FirebaseFirestore.instance.collection('Bookings');
    bookingsCollection
        .where('userEmail', isEqualTo: userEmail)
        .where('date', isGreaterThan: now.toLocal().toString().split(' ')[0])
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      snapshots.value = querySnapshot.docs;
    });
  }

  @override
  void onReady() {
    super.onReady();

    getFutureBookings('abood.al7amed@gmail.com');
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
