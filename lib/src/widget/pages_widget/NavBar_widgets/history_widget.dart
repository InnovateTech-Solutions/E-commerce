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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/history_controller1.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/bookdetail_widget.dart';
import 'package:profile_part/src/widget/partial_widget/booking_partail/not_booked.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpBookingController());
    return Obx(
      () => controller.snapshots.isEmpty
          ? NohistoryWidget()
          : Center(
              child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.0.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    historyMainTexrt("My Appointments"),
                    AppSizes.smallHeightSizedBox,
                    divder(320.w, 0, 0),
                    AppSizes.smallHeightSizedBox,
                    historyMainTexrt('Upcoming Appointments'),
                    AppSizes.smallHeightSizedBox,
                    SizedBox(
                      height: 350.h,
                      width: 350.w,
                      child: ListView.separated(
                        itemBuilder: ((context, index) {
                          DocumentSnapshot snapshot =
                              controller.snapshots[index];
                          Map<String, dynamic> bookingData =
                              snapshot.data() as Map<String, dynamic>;
                          String str = bookingData['vendorName'];
                          String first10Chars = str.substring(0, 15);
                          String ellipsis = "...";
                          String first10CharsWithEllipsis =
                              first10Chars + ellipsis;
                          return GestureDetector(
                            onTap: () {
                              showBookingInfo(context, index);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          historyText(first10CharsWithEllipsis),
                                          Row(
                                            children: [
                                              historyText(bookingData['time']),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              historyText(bookingData['date']),
                                            ],
                                          )
                                        ],
                                      ),
                                      // Container(
                                      //   color: Colors.black,
                                      //   width: 150,
                                      //   height: 100,
                                      //   child: VendorImage(
                                      //       image: bookingData['vendorName']),
                                      // )
                                    ],
                                  ),
                                ),
                                // Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: ColorConstants.mainTextColor,
                                // )
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return AppSizes.mediumHeightSizedBox;
                        },
                        itemCount: controller.snapshots.length,
                      ),
                    )
                  ],
                ),
              ),
            )),
    );
  }
}
