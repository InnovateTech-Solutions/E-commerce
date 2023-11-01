import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/booking_model.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  Future<bool> isTimeSlotAvailable(String date, String time) async {
    final firestore = FirebaseFirestore.instance;
    final bookingsCollection = firestore.collection('Bookings');
    final bookingQuery = await bookingsCollection
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .get();

    return bookingQuery.docs.isEmpty;
  }

  Future<void> createBooking(Booking booking) async {
    final isAvailable = await isTimeSlotAvailable(booking.date, booking.time);

    if (isAvailable) {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('bookings');
      await bookingsCollection.add(booking.toMap());
    } else {
      print('Chosen time slot is not available');
    }
  }
}
