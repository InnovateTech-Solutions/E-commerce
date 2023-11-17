import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs; // Observable for the selected index

  final List<Map<String, dynamic>> allPlayers = [
    {"name": "Rohit Sharma", "country": "India"},
    {"name": "Virat Kohli ", "country": "India"},
    {"name": "Glenn Maxwell", "country": "Australia"},
    {"name": "Aaron Finch", "country": "Australia"},
    {"name": "Martin Guptill", "country": "New Zealand"},
    {"name": "Trent Boult", "country": "New Zealand"},
    {"name": "David Miller", "country": "South Africa"},
    {"name": "Kagiso Rabada", "country": "South Africa"},
    {"name": "Chris Gayle", "country": "West Indies"},
    {"name": "Jason Holder", "country": "West Indies"},
    {"name": "Mohammed r5ess", "country": "Amman naur"},
  ];
  Rx<List<Map<String, dynamic>>> foundPlayers =
      Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() {
    super.onInit();
    foundPlayers.value = allPlayers;
  }

  @override
  void onClose() {}
  void filterPlayer(String playerName) {
    List<Map<String, dynamic>> results = [];
    if (playerName.isEmpty) {
      results = allPlayers;
    } else {
      results = allPlayers
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    foundPlayers.value = results;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Flutter Demo',
      home: TestHistory(),
    );
  }
}

class TestHistory extends StatefulWidget {
  @override
  _TestHistoryState createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {
  List<Map<String, dynamic>> futureBookings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> bookings = await getFutureBookings();
                setState(() {
                  futureBookings = bookings;
                });
              },
              child: Text('Get Future Bookings'),
            ),
            SizedBox(height: 20),
            Text(
              'Future Bookings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: futureBookings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Booking ID: ${futureBookings[index]['bookingId']}',
                    ),
                    subtitle: Text(
                      'Date and Time: ${futureBookings[index]['dateTime']}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getFutureBookings() async {
    DateTime now = DateTime.now();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('Bookings')
        .where('date', isGreaterThanOrEqualTo: now)
        .orderBy('dateTime')
        .get();

    List<Map<String, dynamic>> bookings = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> bookingData =
          document.data() as Map<String, dynamic>;
      bookings.add(bookingData);
    });

    return bookings;
  }
}
