import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/Text_Widget/history_text.dart';
import 'package:profile_part/src/widget/constant_widget/const_widget/constant_widget.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 18.0.h),
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
            /* Builder(builder: (context) {
                              return data.isEmpty
                                  ? Column(
                                      children:[ historyMainTexrt('No Upcoming Appointments'),
                                       AppSizes.smallHeightSizedBox,
                                      historyText("you do not hane upcoming appointment. once you do, they will show up here. now get booking")],
                                      historyText("Past Appointments")],                                  
                                    )
                                  :historyMainTexrt('Upcoming Appointments');*/

            historyMainTexrt('Upcoming\nAppointments'),
            AppSizes.smallHeightSizedBox,
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            height: 70.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                color:
                                    ColorConstants.secondaryScaffoldBacground)),
                        AppSizes.smallWidthSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            historyText("title"),
                            historyText("title"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingService {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('Bookings');

  // Get future bookings in real-time
  Stream<QuerySnapshot> getFutureBookings() {
    DateTime now = DateTime.now();
    return bookingsCollection
        .where('bookingTime', isGreaterThanOrEqualTo: now)
        .snapshots();
  }
}

// Example usage in a Flutter widget
class BookingWidget extends StatelessWidget {
  final BookingService _bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bookingService.getFutureBookings(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No future bookings available.');
        }

        // Process the snapshot data and display the bookings
        List<QueryDocumentSnapshot> bookings = snapshot.data!.docs;
        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            var booking = bookings[index];
            // Extract and display relevant booking information
            return ListTile(
              title: Text(booking['customerName']),
              subtitle: Text('Booking Time: ${booking['bookingTime']}'),
              // Add more details as needed
            );
          },
        );
      },
    );
  }
}
