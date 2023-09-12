import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key, required this.id, required this.category})
      : super(key: key);

  final String id;
  final String category;
  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseservice = Get.put(FirebaseService());
    return FutureBuilder(
      future:
          firebaseservice.getSkinCareSubcollection(widget.category, widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> products = snapshot.data!;
            products.shuffle();
            return Center(
              child: SizedBox(
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          height: AppConst.smallSize.h,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 165,
                            width: 355,
                            child: DashboradContainer(
                                imgName: products[index]['image'],
                                onTap: () => null),
                          ),
                          Row(children: [
                            SizedBox(
                              width: AppConst.medium.w,
                            ),
                            textFieldLabel(products[index]['Title']),
                            SizedBox(
                              width: AppConst.largeSize.w,
                            ),
                            ButtonWidget(onTap: () => null, tilte: 'BOOK NOW ')
                          ]),
                        ],
                      );
                    }),
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
          return const Text("something went wrong");
        }
      },
    );
  }
}
