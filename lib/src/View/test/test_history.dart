import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_part/src/getx/user_controller.dart';

class BookingControllerAboutDate extends GetxController {
  late RxList<DocumentSnapshot<Map<String, dynamic>>> bookings;
  late RxList<DocumentSnapshot<Map<String, dynamic>>> todaybookings;

  @override
  void onInit() {
    super.onInit();
    bookings = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
  }

  void fetchBookingsUpcomming(String userEmail) async {
    try {
      DateTime currentDate = DateTime.now();

      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('userEmail',
              isEqualTo: userEmail) // replace with your username
          .get();

      var filteredBookings = result.docs.where((booking) {
        // Convert the Firestore string date to a DateTime object
        DateTime bookingDate = DateTime.parse(booking['date']);

        // Filter bookings where the date is greater than today
        return bookingDate.isAfter(currentDate);
      }).toList();

      bookings.assignAll(filteredBookings);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  void fetchTodayBookings(String userEmail) async {
    try {
      DateTime currentDate = DateTime.now();

      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('userEmail',
              isEqualTo: userEmail) // replace with your username
          .get();

      var filteredBookings = result.docs.where((booking) {
        // Convert the Firestore string date to a DateTime object
        DateTime bookingDate = DateTime.parse(booking['bookingDate']);

        // Compare only the year, month, and day components
        return bookingDate.year == currentDate.year &&
            bookingDate.month == currentDate.month &&
            bookingDate.day == currentDate.day;
      }).toList();

      todaybookings.assignAll(filteredBookings);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }
}

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingControllerAboutDate controller =
      Get.put(BookingControllerAboutDate());

  @override
  void initState() {
    super.initState();
    controller.fetchBookingsUpcomming(UserController.instance.email.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Obx(() {
        return controller.bookings.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.bookings.length,
                itemBuilder: (context, index) {
                  var bookingData =
                      controller.bookings[index].data() as Map<String, dynamic>;

                  return ListTile(
                    // leading: Row(
                    //   children: [Text('Booking Date: ${bookingData['userEmail']}')],
                    // ),
                    title: Text('Booking Date: ${bookingData['totalPrice']}'),
                    subtitle: Text('Booking Date: ${bookingData['date']}'),
                    leading: Text('Booking Date: ${bookingData['userEmail']}'),
                    // Add more details as needed
                  );
                },
              );
      }),
    );
  }
}

void main() {
  runApp(
    GetMaterialApp(
      home: BookingScreen(),
    ),
  );
}
