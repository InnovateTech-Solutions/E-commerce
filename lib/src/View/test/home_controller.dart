import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/user_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Testpage(),
    );
  }
}

class Testpage extends StatefulWidget {
  @override
  _TestpageState createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  List<Booking> futureBookings = [];
  final userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    getFutureBookingsMagthe().then((bookings) {
      setState(() {
        futureBookings = bookings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format the current date to match the date format stored in the database
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    // Format the current time to match the time format stored in the database
    String formattedTime = "${now.hour}:${now.minute}-${now.minute}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Bookings'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: getFutureBookingsMagthe(),
        builder: (context, snapshot) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () => {
                        print(UserController.instance.email.value),
                        print(futureBookings.length),
                        print(formattedDate),
                        print(formattedTime)
                      },
                  child: Text('text')),
              SizedBox(
                height: 500,
                width: 200,
                child: ListView.builder(
                  itemCount: futureBookings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Date: ${futureBookings[index].date}'),
                      subtitle: Text('Time: ${futureBookings[index].time}'),
                      // Add other fields as needed
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<Booking>> getFutureBookings(String useremail) async {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the current date to match the date format stored in the database
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    // Format the current time to match the time format stored in the database
    String formattedTime = "${now.hour}:${now.minute}:${now.minute}";

    // Query Firebase to get future bookings
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Bookings')
        .where('date', isGreaterThan: formattedDate)
        .get();

    // Process the query results
    List<Booking> futureBookings = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
      Booking booking = Booking.fromMap(documentSnapshot.data());
      futureBookings.add(booking);
    }
    return futureBookings;
  }
}

class Booking {
  final String date;
  final String time;
  // Add other fields as needed

  Booking({
    required this.date,
    required this.time,
    // Add other fields as needed
  });

  factory Booking.fromMap(Map<String, dynamic> data) {
    return Booking(
      date: data['date'],
      time: data['time'],
      // Map other fields accordingly
    );
  }
}

Future<List<Booking>> getFutureBookingsMagthe() async {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Format the current date to match the date format stored in the database
  String formattedDate = "${now.year}-${now.month}-${now.day}";

  // Format the current time to match the time format stored in the database
  String formattedTime = "${now.hour}:${now.minute}-${now.minute}";

  // Query Firebase to get future bookings
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection("Bookings")
      .where('time', isGreaterThan: formattedTime)
      .get();

  // Process the query results
  List<Booking> futureBookings = [];
  for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
      in querySnapshot.docs) {
    Booking booking = Booking.fromMap(documentSnapshot.data());
    futureBookings.add(booking);
  }
  return futureBookings;
}
