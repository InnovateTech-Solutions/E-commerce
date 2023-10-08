/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/map_controller.dart';

class mapDialog extends StatelessWidget {
  mapDialog({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;
  final mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mapController.markers.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstants.backProductButton,
                    borderRadius: BorderRadius.circular(12)),
                height: 120,
                width: 300,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 100,
                          child: Center(child: Icon(Icons.food_bank_sharp)),
                          width: 100,
                          decoration: BoxDecoration(
                              color: ColorConstants.buttonColor,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/