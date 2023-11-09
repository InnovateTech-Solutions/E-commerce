import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/Forms/login_page.dart';
import 'package:profile_part/src/View/checkout/cart_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/app_controller.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/getx/similarItems_controller.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/header_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/rating_widget.dart';
import 'package:profile_part/src/widget/partial_widget/vendor_partial.dart/service_select.dart';

import '../../../getx/reviews_controller.dart';
import '../../../transition/vendor_transition.dart';

class VendorWidget extends GetView<Appcontroller> {
  const VendorWidget({required this.vendor, super.key});
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    final reviewsController = Get.put(ReviewsController(vendor.name));
    final cartController = Get.put(ServiceController());
    final userController = Get.put(UserController());
    final recommendedController = Get.put(VendorController());

    Get.put(Appcontroller());
    return FutureBuilder(
        future: FirebaseService.instance.fetchServicebyName(vendor.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              reviewsController.nonEmptyComments.shuffle();

              final services = snapshot.data!;
              return Stack(
                children: [
                  CustomScrollView(slivers: [
                    SliverAppBar(
                        scrolledUnderElevation: 0,
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
                        height: 1000.h,
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
                              Obx(() => reviewsController.reviews.length == 0
                                  ? ratingBarIndicator('0', '0')
                                  : ratingBarIndicator(
                                      reviewsController.averageRating
                                          .toString(),
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
                                                    print(
                                                        "lenght ${recommendedController.vendors.length}"),
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
                              AppSizes.smallHeightSizedBox,
                              services.isEmpty
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        mainText('Reviews'),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 30.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    reviewsController
                                                        .averageRating
                                                        .toString(),
                                                    style: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp,
                                                      color: ColorConstants
                                                          .mainTextColor,
                                                    ),
                                                  ),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow)
                                                ],
                                              ),
                                              Container(
                                                  height: 40.h,
                                                  width: 120.w,
                                                  decoration: BoxDecoration(
                                                      color: ColorConstants
                                                          .secondaryScaffoldBacground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2.r,
                                                            blurRadius: 3.r,
                                                            offset:
                                                                const Offset(
                                                                    0, 2)),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.r))),
                                                  child: Center(
                                                    child: subvendorText(
                                                        '${reviewsController.reviews.length.toString()}+ reviews'),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                              Obx(
                                () => Column(
                                  children: [
                                    SizedBox(
                                        height: 170.h,
                                        child: reviewsController
                                                .nonEmptyComments.isEmpty
                                            ? Center(
                                                child: mainText(
                                                    'There is no Reviews '),
                                              )
                                            : ListView.separated(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) {
                                                  return AppSizes
                                                      .xsmallHeightSizedBox;
                                                },
                                                shrinkWrap: true,
                                                itemCount: reviewsController
                                                    .nonEmptyComments.length,
                                                itemBuilder: (context, index) {
                                                  List<String> emailPart =
                                                      reviewsController
                                                          .nonEmptyComments[
                                                              index]
                                                          .userEmail
                                                          .split('@');
                                                  String email = emailPart[0];

                                                  return Container(
                                                    width: 330.w,
                                                    height: 80.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.r)),
                                                      color: ColorConstants
                                                          .textFiledmColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .grey[200]!
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2.r,
                                                            blurRadius: 3.r,
                                                            offset:
                                                                const Offset(
                                                                    0, 2)),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 80.h,
                                                              width: 60.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(10
                                                                              .r)),
                                                                  color: ColorConstants
                                                                      .generateRandomColor()),
                                                              child: Center(
                                                                child: Text(
                                                                  reviewsController
                                                                          .nonEmptyComments[
                                                                              index]
                                                                          .userEmail
                                                                          .isEmpty
                                                                      ? 'No user email'
                                                                      : reviewsController
                                                                          .nonEmptyComments[
                                                                              index]
                                                                          .userEmail[
                                                                              0]
                                                                          .toUpperCase(),
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          color: ColorConstants
                                                                              .mainScaffoldBackgroundColor,
                                                                          fontSize: 22
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400)),
                                                                ),
                                                              ),
                                                            ),
                                                            AppSizes
                                                                .smallWidthSizedBox,
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                subvendorText(
                                                                    email),
                                                                Text(
                                                                    reviewsController
                                                                        .nonEmptyComments[
                                                                            index]
                                                                        .comment
                                                                        .toString(),
                                                                    style: GoogleFonts.poppins(
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                                10.sp,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: ColorConstants.mainTextColor))),
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating: reviewsController
                                                                      .nonEmptyComments[
                                                                          index]
                                                                      .rating, // Set the initial rating value
                                                                  minRating:
                                                                      1, // Minimum rating value
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true, // Allow half star rating
                                                                  itemCount:
                                                                      5, // Number of stars to display
                                                                  itemSize:
                                                                      15.0, // Size of each star
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  ignoreGestures:
                                                                      true, // Disable user interaction
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    // This callback is triggered when the rating is updated (not used for static display)
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                })),
                                    recommendedController.vendors.isEmpty
                                        ? Container()
                                        : ElevatedButton(
                                            onPressed: () => print(
                                                recommendedController
                                                    .vendors.length),
                                            child: Text('press me'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  Builder(builder: (context) {
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
                                          color: Colors.grey.withOpacity(0.5),
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
                                          " ${cartController.counter.toString()} BD",
                                          style: TextStyle(
                                            color: ColorConstants
                                                .mainTextColor, // Customize text color
                                            fontSize:
                                                16.0.sp, // Customize text size
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
                                      onTap: () =>
                                          userController.isLoggedIn.value
                                              ? Get.to(CartPage(
                                                  vendorModel: vendor,
                                                ))
                                              : Get.to(LoginPage()),
                                      title: 'Confrim',
                                    )
                                  ],
                                ),
                              ),
                            ),
                    );
                  })
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
