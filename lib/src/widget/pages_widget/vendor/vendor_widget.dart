import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/review_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/header_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/rating_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/service_select.dart';

import '../../../getx/reviews_controller.dart';

class VendorWidget extends GetView<Appcontroller> {
  const VendorWidget({required this.vendor, super.key});
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    final reviewsController = Get.put(ReviewsController(vendor.name));

    reviewDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Form(
              child: AlertDialog(
                title: const Text("Add review"),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          reviewsController.rate = rating;
                          print(reviewsController.rate);
                        },
                      ),
                      AppSizes.mediumHeightSizedBox,
                      const Text("Write a Feedback"),
                      AppSizes.smallHeightSizedBox,
                      FormWidget(
                          login: Login(
                              controller: reviewsController.comment,
                              hintText: 'Review',
                              icon: const Icon(Icons.reviews),
                              invisible: false,
                              validator: null,
                              type: TextInputType.emailAddress,
                              onChange: null,
                              inputFormat: [],
                              enableText: false)),
                      AppSizes.largeHeightSizedBox,
                      GestureDetector(
                        onTap: () => {
                          reviewsController.addReview(Review(
                              userEmail: "abdallah@gmail.com",
                              vendorName: vendor.name,
                              rating: reviewsController.rate,
                              comment: reviewsController.comment.text.trim(),
                              timestamp: DateTime.now())),
                          Get.back(),
                        },
                        child: Container(
                          width: 143.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)),
                              color: ColorConstants.secondaryScaffoldBacground),
                          child: Center(
                            child: Text(
                              'Add Review',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.mainTextColor)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

    Get.put(Appcontroller());
    return FutureBuilder(
        future: FirebaseService.instance.fetchServicebyName(vendor.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;

              return CustomScrollView(slivers: [
                SliverAppBar(
                    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 300.h,
                    flexibleSpace: FlexibleSpaceBar(
                      background: headerWidget(vendor.image),
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    height: 800.h,
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
                          AppSizes.smallHeightSizedBox,
                          vendor.name.length > 30
                              ? mainVendorText(vendor.name)
                              : Row(
                                  children: [
                                    mainVendorText(vendor.name),
                                  ],
                                ),
                          AppSizes.xsmallHeightSizedBox,
                          ratingBarIndicator('4', '150'),
                          AppSizes.xsmallHeightSizedBox,
                          addressText(vendor.coordinates, vendor.address),
                          AppSizes.smallHeightSizedBox,
                          serviceText(),
                          AppSizes.smallHeightSizedBox,
                          SizedBox(
                            height: 85.h,
                            width: double.infinity,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    AppSizes.smallWidthSizedBox,
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () => controller
                                                .currentIndex.value = index,
                                            child: serviceSelcet(
                                                data[index]['Name'],
                                                index,
                                                controller.currentIndex.value)),
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
                                        subvendorText(
                                            data[controller.currentIndex.value]
                                                ['Description']),
                                        AppSizes.mediumHeightSizedBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ProductButton(onTap: () => null),
                                            subvendorText(data[controller
                                                .currentIndex.value]['Price']),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                          }),
                          AppSizes.largeHeightSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Reviews',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                ColorConstants.mainTextColor))),
                              ),
                              GestureDetector(
                                onTap: () => reviewDialog(context),
                                child: Container(
                                  width: 100.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: ColorConstants
                                          .secondaryScaffoldBacground),
                                  child: Center(
                                    child: Text(
                                      'Add review',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: ColorConstants
                                                  .mainTextColor)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 690.h,
                              child: Obx(
                                () => ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: reviewsController.reviews.length,
                                    itemBuilder: ((context, index) => Column(
                                          children: [
                                            Container(
                                              width: double.infinity.w,
                                              height: 50.h,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.0.h,
                                                  horizontal: 4.0.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0.r),
                                                  color: ColorConstants
                                                      .mainScaffoldBackgroundColor),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                          50.r,
                                                        )),
                                                        color: ColorConstants
                                                            .secondaryScaffoldBacground),
                                                  ),
                                                  AppSizes.smallWidthSizedBox,
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(reviewsController
                                                          .reviews[index]
                                                          .userEmail),
                                                      Text(reviewsController
                                                          .reviews[index]
                                                          .comment),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Text(reviewsController
                                                      .reviews[index].rating
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            } else {
              return const Text("something went wrong");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: ColorConstants.mainScaffoldBackgroundColor,
              value: 0.5,
            ));
          } else {
            return const Text("something went wrong");
          }
        });
  }
}
