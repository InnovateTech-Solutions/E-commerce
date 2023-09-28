import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/page_controller.dart';
import 'package:profile_part/src/getx/search_controller.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendor_list_with_search.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendors_display.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final pagecontroller = Get.put(testPageController());

    final controller1 = Get.put(SearchControllerr(title));

    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        leading: Obx(() => pagecontroller.isSearchBarOpen.value
            ? Container()
            : IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorConstants.mainTextColor,
                ))),
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.mainTextColor)),
        ),
        actions: [
          GetXSearchBar(
            title: title,
          ),
        ],
      ),
      body: Obx(() => pagecontroller.isSearchBarOpen.value
          ? SizedBox(
              width: double.infinity,
              height: 690.h,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller1.filteredList.length,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Column(
                      children: [
                        LocationWidget(
                            imageUrl: controller1.filteredList[index].image,
                            name: controller1.filteredList[index].name,
                            description:
                                controller1.filteredList[index].description)
                      ],
                    ));
                  }),
            )
          : VendorDisplayWidget(
              category: title,
            )),
    );
  }
}
/*
class GetXSearchBar extends GetWidget<PageController> {
  const GetXSearchBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    Get.put(PageController());

    final controller1 = Get.put(SearchControllerr(title));

    return Obx(() {
      final searchController = Get.find<PageController>();

      if (searchController.isSearchBarOpen.value) {
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        controller1.filterPlayer(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                          color: ColorConstants.mainTextColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    color: ColorConstants.mainTextColor,

                    icon: const Icon(
                      Icons.close,
                    ), // X icon

                    onPressed: () {
                      searchController.toggleSearchBar();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller1.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Get.to(VendorPage(
                              vendor: controller1.filteredList[index])),
                          print(controller1.filteredList.length)
                        },
                        child: LocationWidget(
                            imageUrl: controller1.filteredList[index].image,
                            name: controller1.filteredList[index].name,
                            description:
                                controller1.filteredList[index].description),
                      );
                    }),
              )
            ],
          ),
        );
      } else {
        return IconButton(
          color: ColorConstants.mainTextColor,
          icon: const Icon(Icons.search),
          onPressed: () {
            searchController.toggleSearchBar();
          },
        );
      }
    });
  }
}

class PageController extends GetxController {
  final RxBool isSearchBarOpen = false.obs;

  final RxString searchQuery = ''.obs;

  void toggleSearchBar() {
    isSearchBarOpen.value = !isSearchBarOpen.value;

    if (!isSearchBarOpen.value) {
      searchQuery.value =
          ''; // Clear the search query when closing the search bar
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}

 

class GetXSearchBar extends GetWidget<PageController> {
  const GetXSearchBar({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    Get.put(PageController());
    final controller1 = Get.put(SearchControllerr(title));

    return Obx(() {
      final searchController = Get.find<PageController>();

      if (searchController.isSearchBarOpen.value) {
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        controller1.filterPlayer(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                          color: ColorConstants.mainTextColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    color: ColorConstants.mainTextColor,
                    icon: const Icon(
                      Icons.close,
                    ), // X icon
                    onPressed: () {
                      searchController.toggleSearchBar();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller1.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Get.to(VendorPage(
                              vendor: controller1.filteredList[index])),
                          print(controller1.filteredList.length)
                        },
                        child: LocationWidget(
                            imageUrl: controller1.filteredList[index].image,
                            name: controller1.filteredList[index].name,
                            description:
                                controller1.filteredList[index].description),
                      );
                    }),
              )
            ],
          ),
        );
      } else {
        return IconButton(
          color: ColorConstants.mainTextColor,
          icon: const Icon(Icons.search),
          onPressed: () {
            searchController.toggleSearchBar();
          },
        );
      }
    });
  }
}

class PageController extends GetxController {
  final RxBool isSearchBarOpen = false.obs;
  final RxString searchQuery = ''.obs;

  void toggleSearchBar() {
    isSearchBarOpen.value = !isSearchBarOpen.value;
    if (!isSearchBarOpen.value) {
      searchQuery.value =
          ''; // Clear the search query when closing the search bar
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/reviews_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/review_model.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

class ReviewsWidget extends GetView<ReviewsController> {
  const ReviewsWidget({required this.vendor, super.key});
  final String vendor;

  @override
  Widget build(BuildContext context) {
    Get.put(ReviewsController(vendor));

    return Column(
      children: [
        Form(
            child: Column(
          children: [
            Row(
              children: [
                //image

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: ColorConstants.secondaryScaffoldBacground),
                ),

                SizedBox(
                  width: AppConst.smallSize.w,
                ),

                const Column(
                  children: [
                    Text("Name"),
                    Text("description"),
                  ],
                ),

                SizedBox(
                  width: AppConst.largeSize.w,
                ),

                const Spacer(),

                textFieldLabel("45"),

                //star
              ],
            ),
            SizedBox(
              height: AppConst.medium.h,
            ),
            ButtonWidget(
              onTap: () => reviewDialog(context),
              tilte: "Add Review",
            )
          ],
        )),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 690.h,
              child: Obx(
                () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.reviews.length,
                    itemBuilder: ((context, index) => Column(
                          children: [
                            Text(controller.reviews[index].comment.toString())
                          ],
                        ))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  reviewDialog(BuildContext context) {
    final reviewsController = Get.put(ReviewsController(vendor));
    final userController = Get.put(UserRepository());

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            child: AlertDialog(
              title: const Text("Add review"),
              content: Column(
                children: [
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      reviewsController.rate = rating;
                      print(reviewsController.rate);
                    },
                  ),
                  SizedBox(
                    height: AppConst.smallSize.h,
                  ),
                  const Text("Write a Feedback"),
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
                  SizedBox(
                    height: AppConst.smallSize.h,
                  ),
                  ButtonWidget(
                    onTap: () {
                      reviewsController.addReview(Review(
                          userEmail: userController.userModel.name,
                          vendorName: vendor,
                          rating: reviewsController.rate,
                          comment: reviewsController.comment.text.trim(),
                          timestamp: DateTime.now()));
                    },
                    tilte: 'submit',
                  )
                ],
              ),
            ),
          );
        });
  }
}
*/