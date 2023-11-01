import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';

class TestVersion extends StatelessWidget {
  const TestVersion({super.key});

  @override
  Widget build(BuildContext context) {
    RxString selectedDate = (DateTime.now()).toString().obs;
    DateTime parsingDate = DateTime.parse(selectedDate.value);
    RxString seletedTimeStamp = ''.obs;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
        ),
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              selectedBackgroundColor: ColorConstants.mainTextColor,
              compactMode: true,
              weekDaySelectedColor: ColorConstants.mainTextColor,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
              headerTextColor: ColorConstants.mainTextColor,
              resetDateColor: ColorConstants.mainTextColor,
              calendarIconColor: ColorConstants.mainTextColor,
              navigationColor: ColorConstants.mainTextColor),
          onChangeDateTime: (datetime) {
//            print(datetime.getDate());

            selectedDate.value = datetime.getDate();
          },
        ),
        Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      indent: 20.0,
                      endIndent: 10.0,
                      thickness: 1,
                      color: ColorConstants.textFiledmColor,
                    ),
                itemCount: AppConst.timeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            //  print(selectedDate.value),
                            // print(AppConst.timeList[index]),
                            // bookAppointment(
                            //  selectedDate.value, AppConst.timeList[index]),

                            print(seletedTimeStamp.value =
                                '${selectedDate.value}  ${AppConst.timeList[index]}'),
                            //  addTimestampToDatabase(DateTime.parse(
                            //    '${selectedDate.value}${AppConst.timeList[index]}'))
                            print(parsingDate)
                          },
                          child: Text(AppConst.timeList[index],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.mainTextColor))),
                        )
                      ],
                    ),
                  );
                }))
      ],
    ));
  }
}

void addTimestampToDatabase(DateTime timestamp) {
  // Create a DateTime object representing the timestamp
  timestamp = DateTime.now();

  // Convert the DateTime to Firebase Timestamp
  Timestamp timestampFirestore = Timestamp.fromDate(timestamp);

  // Add the timestamp to Firebase Firestore
  FirebaseFirestore.instance.collection('timestamps').add({
    'timestamp': timestampFirestore,
  }).then((DocumentReference document) {
    print('Timestamp added to Firestore with ID: ${document.id}');
  }).catchError((error) {
    print('Error adding timestamp to Firestore: $error');
  });
}

void bookAppointment(String selectedDate, String selectedTime) {
  FirebaseFirestore.instance.collection('appointments').add({
    'date': selectedDate,
    'time': selectedTime,
  }).then((value) {
    return Get.snackbar('Success', '${selectedDate} the appointments is Booked',
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

TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String time2 = '2023-11-21 10:11:49';

  @override
  Widget build(BuildContext context) {
    // Convert the DateTime to a Firebase Timestamp
    Timestamp firebaseTimestamp = Timestamp.fromDate(DateTime.parse(time2));

    // Now, you can send `firebaseTimestamp` to Firebase database
    // For example, assuming you have a Firestore collection reference:

    FirebaseFirestore.instance.collection('your_collection_name').add({
      'timestampField': firebaseTimestamp,
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Timestamp Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Concatenated String: $time2'),
            Text('Firebase Timestamp: ${firebaseTimestamp.toDate()}'),
            ElevatedButton(
                onPressed: () => FirebaseFirestore.instance
                        .collection('your_collection_name')
                        .add({
                      'timestampField': firebaseTimestamp,
                    }),
                child: Text('a'))
          ],
        ),
      ),
    );
  }
}
*/