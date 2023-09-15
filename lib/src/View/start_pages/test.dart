import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class ExampleParallax extends StatelessWidget {
  const ExampleParallax({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());

    return FutureBuilder(
      future: firebaseservice.getAllCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> categories = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 690.h,
                    child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: ((context, index) {
                          return LocationWidget(
                            imageUrl: categories[index]['image'],
                            name: categories[index]['Title'],
                            description: categories[index]['id'],
                          );
                        })),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error${snapshot.error}'));
          } else {
            return const Text("something went wrong");
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Text("somthing went wrong");
        }
      },
    );
  }
}
