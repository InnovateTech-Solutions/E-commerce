import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/user_controller.dart';

class BookingControllerAboutDate extends GetxController {
  late RxList<DocumentSnapshot<Map<String, dynamic>>> bookings;
  late RxList<DocumentSnapshot<Map<String, dynamic>>> bookingsToday;

  @override
  void onInit() {
    super.onInit();
    bookings = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
    fetchBookings(UserController.instance.email.value);
    bookingsToday = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
  }

  void fetchBookingsUpcomming(String userEmail) async {
    try {
      DateTime currentDate = DateTime.now();

      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .orderBy('date', descending: true)
          .where('userEmail',
              isEqualTo: userEmail) // replace with your username
          .get();

      var filteredBookings = result.docs.where((booking) {
        DateTime bookingDate = DateTime.parse(booking['date']);

        // Filter bookings where the date is greater than today
        return bookingDate.isAfter(currentDate);
      }).toList();

      bookings.assignAll(filteredBookings);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  void fetchBookings(String userEmail) async {
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

        // Compare only the year, month, and day components
        return bookingDate.year == currentDate.year &&
            bookingDate.month == currentDate.month &&
            bookingDate.day == currentDate.day;
      }).toList();

      bookingsToday.assignAll(filteredBookings);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  Future<String> getImageUrl(String name) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Vendors')
          .where('Name', isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var imageUrl = querySnapshot.docs.first.get('Image');

        if (imageUrl is String) {
          return imageUrl;
        } else {
          print('Error: "imgUrl" field is not a String.');
          return 'null';
        }
      } else {
        return 'null';
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return "null";
    }
  }
}
