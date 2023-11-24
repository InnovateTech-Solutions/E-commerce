import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {
  late RxList<DocumentSnapshot<Map<String, dynamic>>> bookings;

  @override
  void onInit() {
    super.onInit();
    bookings = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
    fetchBookings();
  }

  void fetchBookings() async {
    try {
      DateTime currentDate = DateTime.now();

      var result = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userName',
              isEqualTo: 'exampleUserName') // replace with your username
          .get();

      var filteredBookings = result.docs.where((booking) {
        // Convert the Firestore string date to a DateTime object
        DateTime bookingDate = DateTime.parse(booking['bookingDate']);

        // Filter bookings where the date is greater than today
        return bookingDate.isAfter(currentDate);
      }).toList();

      bookings.assignAll(filteredBookings);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }
}

class BookingScreen extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Obx(() {
        if (controller.bookings.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            var bookingData =
                controller.bookings[index].data() as Map<String, dynamic>;

            return ListTile(
              title: Text('Booking ID: ${controller.bookings[index].id}'),
              subtitle: Text('Booking Date: ${bookingData['bookingDate']}'),
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
