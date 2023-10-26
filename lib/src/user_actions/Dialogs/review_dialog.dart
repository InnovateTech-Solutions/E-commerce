import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/reviews_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/review_model.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';

reviewDialog(BuildContext context, String vendorName) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final reviewsController = Get.put(ReviewsController(vendorName));

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
                          userEmail: 'userEmail.value',
                          vendorName: vendorName,
                          rating: reviewsController.rate,
                          comment: reviewsController.comment.text.trim(),
                          timestamp: DateTime.now())),
                      Get.back(),
                    },
                    child: Container(
                      width: 143.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
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
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
