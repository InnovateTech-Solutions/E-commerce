import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';

class Testpage extends StatefulWidget {
  const Testpage({Key? key}) : super(key: key);

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());

    return FutureBuilder(
      future: firebaseservice.getServicesByCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> categories = snapshot.data!;

            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(categories[index]['Category']),
                    ],
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        } else {
          return Text('Somthing wroing');
        }
      },
    );
  }
}
