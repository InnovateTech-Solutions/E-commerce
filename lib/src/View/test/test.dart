/*
class ServerController extends GetxController {
  RxList<Server> servers = <Server>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the list of servers here
    servers.addAll([
      Server("Server 1", false.obs),
      Server("Server 2", false.obs),
      Server("Server 3", false.obs),

      // Add more servers as needed
    ]);
  }

  void toggleServerSelection(int index) {
    servers[index].isSelected.value = !servers[index].isSelected.value;
  }
}

class Server {
  String name;
  RxBool isSelected = false.obs;

  Server(this.name, this.isSelected);
}

class MyApp extends GetView<ServerController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServerController());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Server Selection"),
        ),
        body: Container(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: controller.servers.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => controller.servers[index].isSelected.value
                      ? ListTile(
                          title: Text(controller.servers[index].name),
                          onTap: () {
                            // Toggle the server selection
                            controller.toggleServerSelection(index);
                          },
                          tileColor: Colors.grey)
                      : ListTile(
                          title: Text(controller.servers[index].name),
                          onTap: () {
                            // Toggle the server selection
                            controller.toggleServerSelection(index);
                          },
                          tileColor: Colors.red),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking System'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected Date: ${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            Text(
              "Selected Time: ${selectedTime.format(context)}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select time'),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement Firebase data storage here
                // You'll need to send selectedDate and selectedTime to Firebase.
                bookAppointment(selectedDate, selectedTime);
                print(selectedDate);
                print(selectedTime);
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  void bookAppointment(DateTime selectedDate, TimeOfDay selectedTime) {
    FirebaseFirestore.instance.collection('appointments').add({
      'date': selectedDate.toLocal(),
      'time': selectedTime.format(context),
    }).then((value) {
      return Get.snackbar(
          'Success', '${selectedDate} the appointments is Booked',
          snackPosition: SnackPosition.TOP,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorsuccessful);
    }).catchError((error) {
      // Handle errors
      return Get.snackbar('Filed', '${selectedDate} the appointments is Booked',
          snackPosition: SnackPosition.TOP,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    });
  }
}
/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => {}, child: Text('remove'))
          ],
        ),
      ),
    );
  }
}*/
