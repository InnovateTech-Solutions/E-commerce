import 'package:ecommerce/src/constant/profile_list.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:ecommerce/src/widget/pages_wide/sitting/deleteaccount_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../repository/user_repository/user_repository.dart';

class SittingWidget extends StatelessWidget {
  final controller = Get.put(UserRepository());

  SittingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                buildDialog(context);
              },
              child: Text("language")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeleteUserAccount()));
                ;
              },
              child: Text("delete")),
          Expanded(
              child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft, child: mainText("Sitting")),
              divder(150, 0, 0)
            ],
          )),
          Expanded(
            flex: 4,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: SittingContent.sitting.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return SittingContent.sitting[index];
                }),
          ),
        ],
      ),
    );
  }
}
