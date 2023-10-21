import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/checkout/confirm_page.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/vendor_model.dart';

class AppointmentsWidget extends StatefulWidget {
  const AppointmentsWidget({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  State<AppointmentsWidget> createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget> {
  @override
  Widget build(BuildContext context) {
    RxString selectedDate = (DateTime.now()).toString().obs;
    DateTime parsingDate = DateTime.parse(selectedDate.value);
    RxString seletedTimeStamp = ''.obs;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
                            print(parsingDate),
                            Get.to(ConfirmPage(vendorModel: widget.vendorModel))
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
    );
  }
}
