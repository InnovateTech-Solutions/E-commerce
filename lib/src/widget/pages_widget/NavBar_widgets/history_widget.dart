// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:profile_part/src/getx/history_controller1.dart';
// import 'package:profile_part/src/getx/user_controller.dart';
// import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
// import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
// import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

// class HistoryWidget extends StatefulWidget {
//   const HistoryWidget({super.key});

//   @override
//   State<HistoryWidget> createState() => _HistoryWidgetState();
// }

// class _HistoryWidgetState extends State<HistoryWidget> {
//   @override
//   Widget build(BuildContext context) {
//     late StreamSubscription<QuerySnapshot> subscription;
//     RxString imageName = ''.obs;
//     List<DocumentSnapshot> snapshots = <DocumentSnapshot>[].obs;

//     final controller = Get.put(HistoryController());
//     Future<void> getFutureBookings(String userId) async {
//       DateTime now = DateTime.now();

//       final bookingsCollection = await FirebaseFirestore.instance
//           .collection('Bookings')
//           .where('userEmail', isEqualTo: userId);

//       subscription = bookingsCollection
//           .where(
//             'date',
//             isGreaterThan: now.toLocal().toString().split(' ')[0],
//           )
//           .snapshots()
//           .listen((QuerySnapshot querySnapshot) {
//         setState(() {
//           snapshots = querySnapshot.docs;
//         });
//       });
//     }

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.0.h),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             historyMainTexrt("My Appointments"),
//             AppSizes.smallHeightSizedBox,
//             divder(320.w, 0, 0),
//             AppSizes.smallHeightSizedBox,
//             historyMainTexrt('Upcoming Appointments'),
//             AppSizes.smallHeightSizedBox,
//             // ElevatedButton(
//             //   onPressed: () {
//             //     // Replace 'your_user_id' with the actual user ID
//             //     getFutureBookings(UserController.instance.email.value);
//             //   },
//             //   child: Text('Get Future Bookings'),
//             // ),
//             //   Expanded(
//             //     child: ListView.builder(
//             //       itemCount: snapshots.length,
//             //       itemBuilder: (context, index) {
//             //         // Customize how you want to display each booking in the list

//             //         return ListTile(
//             //           title: Column(
//             //             children: [
//             //               Text(snapshots[index]['vendorName']),
//             //               Text(snapshots[index]['time']),
//             //               Text(snapshots[index]['date']),
//             //               Text(snapshots[index]['userEmail']),
//             //               SizedBox(
//             //                 height: 100,
//             //                 width: 200,
//             //                 child: ListView.builder(
//             //                     itemCount: controller
//             //                         .snapshots[index]['services'].length,
//             //                     itemBuilder: (context, indexx) {
//             //                       final x = snapshots[index]['services'][indexx];
//             //                       return Text(x);
//             //                     }),
//             //               )
//             //             ],
//             //           ),
//             //         );
//             //       },
//             //     ),
//             //   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/history_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/helpers/actions/get_vendor_image.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final controller = Get.put(BookingControllerAboutDate());

  @override
  void initState() {
    super.initState();
    controller.fetchBookingsUpcomming(UserController.instance.email.value);
    controller.fetchBookings(UserController.instance.email.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.bookingsToday.isEmpty && controller.bookings.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  historyMainTexrt('Appointments'),
                  AppSizes.smallHeightSizedBox,
                  divder(320.w, 0, 0),
                  AppSizes.smallHeightSizedBox,
                  controller.bookingsToday.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            historyMainTexrt('Today Appointments'),
                            SizedBox(
                              height: 100.h * controller.bookingsToday.length,
                              width: 350.w,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.bookingsToday.length,
                                itemBuilder: (context, index) {
                                  var bookingData =
                                      controller.bookingsToday[index].data()
                                          as Map<String, dynamic>;
                                  String str = bookingData['vendorName'];
                                  String first10Chars = str.substring(0, 10);
                                  String ellipsis = "...";
                                  String first10CharsWithEllipsis =
                                      first10Chars + ellipsis;
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              VendorImage(
                                                  image: bookingData[
                                                      'vendorName']),
                                              AppSizes.smallWidthSizedBox,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  historyText(
                                                      first10CharsWithEllipsis),
                                                  Row(
                                                    children: [
                                                      historyText(
                                                          bookingData['date']),
                                                      SizedBox(width: 80.w),
                                                      historyText(
                                                          bookingData['time'])
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  AppSizes.smallHeightSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      historyMainTexrt('Upcomming Appointments'),
                      SizedBox(
                        height: 90.h * controller.bookings.length,
                        width: 350.w,
                        child: ListView.builder(
                          itemCount: controller.bookings.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var bookingData = controller.bookings[index].data()
                                as Map<String, dynamic>;
                            String str = bookingData['vendorName'];
                            String first10Chars = str.substring(0, 10);
                            String ellipsis = "...";
                            String first10CharsWithEllipsis =
                                first10Chars + ellipsis;
                            return GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 70.h,
                                            width: 75.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                color: ColorConstants
                                                    .secondaryScaffoldBacground,
                                                image: DecorationImage(
                                                    image: NetworkImage('')))),
                                        AppSizes.smallWidthSizedBox,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            historyText(
                                                first10CharsWithEllipsis),
                                            Row(
                                              children: [
                                                historyText(
                                                    bookingData['date']),
                                                SizedBox(width: 80.w),
                                                historyText(bookingData['time'])
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
