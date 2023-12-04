import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';

import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class HistoryAvailable extends GetView<BookingControllerAboutDate> {
  const HistoryAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingControllerAboutDate());
    return Obx(
      () => controller.bookings.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                historyMainTexrt("My Appointments"),
                AppSizes.smallHeightSizedBox,
                divder(320.w, 0, 0),
                AppSizes.smallHeightSizedBox,
                historyMainTexrt('Upcoming\nAppointments'),
                AppSizes.smallHeightSizedBox,
                SizedBox(
                  height: 350.h,
                  width: 350.w,
                  child: ListView.separated(
                    itemBuilder: ((context, index) {
                      return Text(controller.bookings[index]['date']);
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return AppSizes.mediumHeightSizedBox;
                    },
                    itemCount: controller.bookings.length,
                  ),
                )
              ],
            ),
    );
  }
}

class TestBook extends StatefulWidget {
  @override
  _TestBookState createState() => _TestBookState();
}

class _TestBookState extends State<TestBook> {
  late StreamSubscription<QuerySnapshot> subscription;
  RxString rxString = ''.obs;

  List<DocumentSnapshot> snapshots = [];
  final _authRepo = Get.put(AuthenticationRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return UserRepository.instance.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> getFutureBookings(String userId) async {
    DateTime now = DateTime.now();

    final bookingsCollection = await FirebaseFirestore.instance
        .collection('Bookings')
        .where('userEmail', isEqualTo: userId);

    subscription = bookingsCollection
        .where(
          'date',
          isGreaterThan: now.toLocal().toString().split(' ')[0],
        )
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      setState(() {
        snapshots = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    RxString vendorname = ''.obs;
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Bookings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              print(now.toLocal().toString().split(' ')[1]);
              print(now.toLocal().toString().split(' ')[0]);
              print('${now.hour}:${now.minute}');
              // Replace 'your_user_id' with the actual user ID
              getFutureBookings(UserController.instance.email.value);
              Future<String> vendorimage =
                  getImageNamebyvendor(vendorname.value);
              print(rxString.value);
              print(vendorimage);
            },
            child: Text('Get Future Bookings'),
          ),
          SizedBox(height: 20),
          Text('Future Bookings:'),
          Expanded(
            child: ListView.builder(
              itemCount: snapshots.length,
              itemBuilder: (context, index) {
                // Customize how you want to display each booking in the list

                return ListTile(
                  title: Column(
                    children: [
                      Text(snapshots[index]['vendorName']),
                      Text(snapshots[index]['time']),
                      Text(snapshots[index]['date']),
                      Text(snapshots[index]['userEmail']),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: ListView.builder(
                            itemCount: snapshots[index]['services'].length,
                            itemBuilder: (context, indexx) {
                              final x = snapshots[index]['services'][indexx];
                              return Text(x);
                            }),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getImageNamebyvendor(String vendorName) async {
    try {
      // Get reference to the Firestore collection
      CollectionReference vendors =
          FirebaseFirestore.instance.collection('Vendors');

      // Query the collection based on vendor name
      QuerySnapshot querySnapshot =
          await vendors.where('vendorName', isEqualTo: vendorName).get();

      // Check if there is a matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the imgname field from the first document
        String imgName = querySnapshot.docs.first.get('Image');
        rxString.value = imgName;
        return imgName;
      } else {
        // No matching document found
        return 'null';
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error getting image name: $e');
      return 'null';
    }
  }
}
