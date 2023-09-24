import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/test/home_controller.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/product_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorWidget extends GetView<Appcontroller> {
  const VendorWidget({required this.product, super.key});
  final Product product;

  Future<void> launchMap(String address) async {
    final List<String> coordinates = address.split(',');
    if (coordinates.length != 2) {
      throw "Invalid address format";
    }

    final String latitude = coordinates[0];
    final String longitude = coordinates[1];

    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String appleMapsUrl = "https://map.apple.com/?q=$latitude,$longitude";

    final Uri googleMapsUri = Uri.parse(googleMapsUrl);
    final Uri appleMapsUri = Uri.parse(appleMapsUrl);

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else if (await canLaunchUrl(appleMapsUri)) {
        await launchUrl(appleMapsUri);
      } else {
        throw "Couldn't launch URL";
      }
    } catch (e) {
      throw "Error launching URL: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Appcontroller());
    return FutureBuilder(
        future: FirebaseService.instance.fetchServicebyName(product.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                          height: 250.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.r),
                                bottomRight: Radius.circular(15.r)),
                            image: DecorationImage(
                                image: NetworkImage(product.image),
                                fit: BoxFit.cover),
                          )),
                      Container(
                        height: 500.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            color: ColorConstants.mainScaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15.0.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.r,
                                  blurRadius: 3.r,
                                  offset: const Offset(0, 2)),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppConst.smallSize.h,
                              ),
                              product.name.length > 30
                                  ? Text(product.name,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants
                                                  .mainTextColor)))
                                  : Row(
                                      children: [
                                        Text(product.name,
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants
                                                        .mainTextColor))),
                                      ],
                                    ),
                              Row(
                                children: [
                                  Text('4.9',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  RatingBarIndicator(
                                      rating: 4.9,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          )),
                                  Text('(${150})',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => launchMap(
                                      '31.836398564312393,35.55015753954649'),
                                  child: Text('Bahrain Mall, Sanabis, Bahrain',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                ),
                              ),
                              SizedBox(
                                height: AppConst.smallSize,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Service',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                ColorConstants.mainTextColor))),
                              ),
                              SizedBox(
                                height: AppConst.smallSize.h,
                              ),
                              SizedBox(
                                height: 85.h,
                                width: double.infinity,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: AppConst.smallSize.w,
                                        ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () => Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () => controller
                                                  .currentIndex.value = index,
                                              child: Container(
                                                width: 120.w,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                  color: controller.currentIndex
                                                              .value ==
                                                          index
                                                      ? Colors.white70
                                                      : Colors.white54,
                                                  borderRadius: controller
                                                              .currentIndex
                                                              .value ==
                                                          index
                                                      ? BorderRadius.circular(
                                                          15)
                                                      : BorderRadius.circular(
                                                          10),
                                                  border: controller
                                                              .currentIndex
                                                              .value ==
                                                          index
                                                      ? Border.all(
                                                          color: ColorConstants
                                                              .mainTextColor,
                                                          width: 2.w)
                                                      : null,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data[index]['Name'],
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: controller
                                                                    .currentIndex
                                                                    .value ==
                                                                index
                                                            ? Colors.black
                                                            : Colors.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Builder(builder: (context) {
                                return data.isEmpty
                                    ? Center(
                                        child: mainText('No Service Available'),
                                      )
                                    : Obx(
                                        () => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            textFieldLabel(data[controller
                                                .currentIndex
                                                .value]['Description']),
                                            SizedBox(
                                              height: AppConst.medium.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ProductButton(
                                                    onTap: () => null),
                                                textFieldLabel(data[controller
                                                    .currentIndex
                                                    .value]['Price']),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                              })
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
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
        });
  }
}
