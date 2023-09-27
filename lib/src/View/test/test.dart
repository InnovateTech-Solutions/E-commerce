import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/test/home_controller.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';

class HomeView extends GetView<Appcontroller> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Appcontroller());
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: FirebaseService.instance
              .fetchServicebyName('The Talking Therapists W.L.L'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Obx(() => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => controller
                                            .currentIndex.value = index,
                                        child: Container(
                                          width: 116,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            color:
                                                controller.currentIndex.value ==
                                                        index
                                                    ? Colors.white70
                                                    : Colors.white54,
                                            borderRadius:
                                                controller.currentIndex.value ==
                                                        index
                                                    ? BorderRadius.circular(15)
                                                    : BorderRadius.circular(10),
                                            border: controller
                                                        .currentIndex.value ==
                                                    index
                                                ? Border.all(
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                    width: 2)
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              data[index]['Price'],
                                              style: GoogleFonts.laila(
                                                  fontWeight: FontWeight.w500,
                                                  color: controller.currentIndex
                                                              .value ==
                                                          index
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(data[index]['Name'])
                                    ],
                                  ));
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() =>
                          Text(data[controller.selectedIndex.value]['Name']))
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error${snapshot.error}'));
              } else {
                return const Text("something went wrong");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Text("something went wrong");
            }
          },
        ),
      ),
    );
  }

  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return const Column(
          children: [
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
            Text('Widget 0'),
          ],
        );
      case 1:
        return const Text('Widget 1');
      case 2:
        return const Text('Widget 2');
      case 3:
        return const Text('Widget 3');
      default:
        return Container();
    }
  }
}

class HomePage extends GetView<Appcontroller> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320.w,
        height: 50.h,
        margin: EdgeInsets.only(bottom: 0.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(5.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                width: 150.w,
                height: 50.h,
                margin: EdgeInsets.only(bottom: 0.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: controller.tabstatus.value
                    ? BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        color: Colors.white,
                        boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.r,
                                blurRadius: 3.r,
                                offset: const Offset(0, 2)),
                          ])
                    : const BoxDecoration(),
                child: const Center(child: Text('CHAT')),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 150.w,
                height: 50.h,
                margin: EdgeInsets.only(bottom: 0.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.r,
                          blurRadius: 3.r,
                          offset: const Offset(0, 2)),
                    ]),
                child: const Center(child: Text('call')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
