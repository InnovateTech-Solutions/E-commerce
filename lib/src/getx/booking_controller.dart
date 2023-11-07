import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/booking_model.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();
  RxList bookedTimelist = [].obs;
  RxList timeList = [].obs;

  Future<bool> isTimeSlotAvailable(Booking booking) async {
  final firestore = FirebaseFirestore.instance;
  final bookingsCollection = firestore.collection('Bookings');
  final bookingQuery = await bookingsCollection
      .where('vendorName', isEqualTo: booking.vendorName)
      .where('date', isEqualTo: booking.date)
      .where('time', isEqualTo: booking.time)
      .get();
      print(bookingQuery.docs.isEmpty);

  return bookingQuery.docs.isEmpty;
}
Future<void> createBooking(Booking booking) async {
  final isAvailable = await isTimeSlotAvailable(booking);
  
  if (isAvailable) {

    final firestore = FirebaseFirestore.instance;
    final bookingsCollection = firestore.collection('Bookings');
    await bookingsCollection.add(booking.toMap());
    timeList.remove(booking.time);    
  } else {

    print('Chosen time slot is not available');
  }
}

// Future<void> getTimeList(String enteredDate, String vendor) async {
//   final CollectionReference bookingsCollection =
//       FirebaseFirestore.instance.collection('Bookings');

//   QuerySnapshot querySnapshot = await bookingsCollection
//       .where('vendorName', isEqualTo: vendor)
//       .where('date', isEqualTo: enteredDate)
//       .get();
//   if (querySnapshot.docs.isNotEmpty) {
//     querySnapshot.docs.forEach((doc) {
//       final time = doc['time'];
//       if( !bookedTimelist.contains(time))
//           bookedTimelist.add(time);
      
//     });
//   }
// //  print("bookedTimelist:   ${bookedTimelist}");
// }

// Future<void> generateTimeList(String timeRange, String date, String vendor) async {

//   final parts = timeRange.split(' -');
  
//   if (parts.length != 2) {
//     print("error: start and end time should be specified");
//     return;
//   }
  
//   final startTime = parts[0];
//   final endTime = parts[1];

//   final startHour = int.parse(startTime.split(':')[0]);
//   final startMinute = int.parse(startTime.split(':')[1]);
//   final endHour = int.parse(endTime.split(':')[0]);
//   final endMinute = int.parse(endTime.split(':')[1]);      
//   DateTime currentTime = DateTime(2023, 1, 1, startHour, startMinute);
//   await getTimeList(date, vendor);
//   print(date);
//   print("bookedTimelist: ${bookedTimelist}");

//   while (currentTime.hour < endHour || (currentTime.hour == endHour && currentTime.minute <= endMinute)) {
//     final time = '${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}';

//     if (!bookedTimelist.contains(time) && !timeList.contains(time)) {
//         timeList.add(time);

//        print("Checking time: $time");
//     }

   


//     currentTime = currentTime.add(Duration(minutes: 30)); // Increment by 30 minutes
//   }

//   print("timeList: ${timeList}");
// }

Future<void> getTimeList(String enteredDate, String vendor) async {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('Bookings');

  QuerySnapshot querySnapshot = await bookingsCollection
      .where('vendorName', isEqualTo: vendor)
      .where('date', isEqualTo: enteredDate)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    querySnapshot.docs.forEach((doc) {
      final time = doc['time'];
      if( !bookedTimelist.contains(time))
          bookedTimelist.add(time);
      
    });
  }
//  print("bookedTimelist:   ${bookedTimelist}");
}

Future<void> generateTimeList(String timeRange, String date, String vendor) async {

  final parts = timeRange.split(' -');
  
  if (parts.length != 2) {
    print("error: start and end time should be specified");
    return;
  }
  
  final startTime = parts[0];
  final endTime = parts[1];

  final startHour = int.parse(startTime.split(':')[0]);
  final startMinute = int.parse(startTime.split(':')[1]);
  final endHour = int.parse(endTime.split(':')[0]);
  final endMinute = int.parse(endTime.split(':')[1]);      
  DateTime currentTime = DateTime(2023, 1, 1, startHour, startMinute);
  await getTimeList(date, vendor);
  print(date);
  print("bookedTimelist: ${bookedTimelist}");

  while (currentTime.hour < endHour || (currentTime.hour == endHour && currentTime.minute <= endMinute)) {
    final time = '${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}';

    if (!bookedTimelist.contains(time) && !timeList.contains(time)) {
        timeList.add(time);

       print("Checking time: $time");
    }

   


    currentTime = currentTime.add(Duration(minutes: 30)); // Increment by 30 minutes
  }

  print("timeList: ${timeList}");
}

}
