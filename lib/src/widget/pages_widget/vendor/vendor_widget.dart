import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/review_model.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/transition/vendor_transition.dart';
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
    final cartController = Get.put(ServiceController());
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
        future: Future.delayed(
          const Duration(milliseconds: 500),
          () => FirebaseService.instance.fetchServicebyName(vendor.name),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final services = snapshot.data!;
              return Stack(
                children: [
                  CustomScrollView(slivers: [
                    SliverAppBar(
                        backgroundColor:
                            ColorConstants.mainScaffoldBackgroundColor,
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
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              Obx(() => reviewsController.reviews.isEmpty
                                  ? Container()
                                  : ratingBarIndicator(
                                      '4.5',
                                      reviewsController.reviews.length
                                          .toString())),
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
                                    itemCount: services.length,
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () => Column(
                                          children: [
                                            GestureDetector(
                                                onTap: () => {
                                                      controller.currentIndex
                                                          .value = index,
                                                    },
                                                child: serviceSelcet(
                                                    services[index].name,
                                                    index,
                                                    controller
                                                        .currentIndex.value)),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Builder(builder: (context) {
                                // Check if a service with a specific name exists in the list
                                // bool serviceExists = cartController.cartItems
                                //     .any((service) =>
                                //         service.serviceModel.name ==
                                //         service.serviceModel.name);

                                return services.isEmpty
                                    ? Center(
                                        child: mainText('No Service Available'),
                                      )
                                    : Obx(
                                        () => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            subvendorText(services[controller
                                                    .currentIndex.value]
                                                .description),
                                            AppSizes.mediumHeightSizedBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ProductButton(
                                                  onTap: () => {
                                                    cartController
                                                        .toggleService(services[
                                                            controller
                                                                .currentIndex
                                                                .value]),
                                                    print(
                                                        '${services[controller.currentIndex.value].isSelected}  + ${controller.currentIndex.value}'),
                                                  },
                                                  title: 'Book',
                                                ),
                                                subvendorText(services[
                                                        controller
                                                            .currentIndex.value]
                                                    .price),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                              }),
                              AppSizes.largeHeightSizedBox,
                              services.isEmpty
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Reviews',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorConstants
                                                          .mainTextColor))),
                                        ),
                                        GestureDetector(
                                          onTap: () => reviewDialog(context),
                                          child: Container(
                                            width: 100.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.r)),
                                                color: ColorConstants
                                                    .secondaryScaffoldBacground),
                                            child: Center(
                                              child: Text(
                                                'Add review',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                    () => reviewsController.reviews.isEmpty
                                        ? Center(
                                            child: mainText(
                                                'No reviews Available'),
                                          )
                                        : ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: reviewsController
                                                .reviews.length,
                                            itemBuilder: ((context, index) =>
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity.w,
                                                      height: 50.h,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4.0.h,
                                                              horizontal:
                                                                  4.0.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0.r),
                                                          color: ColorConstants
                                                              .mainScaffoldBackgroundColor),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius
                                                                            .circular(
                                                                      50.r,
                                                                    )),
                                                                    color: ColorConstants
                                                                        .secondaryScaffoldBacground),
                                                          ),
                                                          AppSizes
                                                              .smallWidthSizedBox,
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(reviewsController
                                                                  .reviews[
                                                                      index]
                                                                  .userEmail),
                                                              Text(
                                                                  reviewsController
                                                                      .reviews[
                                                                          index]
                                                                      .comment),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Text(reviewsController
                                                              .reviews[index]
                                                              .rating
                                                              .toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  services.isEmpty
                      ? Container()
                      : Builder(builder: (context) {
                          //   String price = services[controller.currentIndex.value]
                          //       .price
                          //      .replaceAll('BD', '');
                          //  int priceoverall = int.parse(price);

                          return Obx(
                            () => cartController.cartItems.isEmpty
                                ? Container()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity.w,
                                      height: 75.h,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2.r,
                                                blurRadius: 3.r,
                                                offset: const Offset(0, 2)),
                                          ],
                                          color: ColorConstants
                                              .mainScaffoldBackgroundColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "BD ${cartController.counter.toString()}",
                                                style: TextStyle(
                                                  color: ColorConstants
                                                      .mainTextColor, // Customize text color
                                                  fontSize: 16.0
                                                      .sp, // Customize text size
                                                ),
                                              ),
                                              Text(
                                                '${cartController.cartItems.length} Service',
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .mainTextColor, // Customize text color
                                                    fontSize: 10.0.sp,
                                                    fontWeight: FontWeight.w300
                                                    // Customize text size
                                                    ),
                                              ),
                                            ],
                                          ),
                                          ProductButton(
                                            onTap: () => {
                                              cartController.clearCart(),
                                            },
                                            title: 'Confrim',
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          );
                        }),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error${snapshot.error}'));
            } else {
              return const Text("something went wrong");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return VendorTransition();
          } else {
            return const Text("something went wrong");
          }
        });
  }
}
