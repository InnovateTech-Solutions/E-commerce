import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/constant/app_const.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/reviews_controller.dart';
import 'package:profile_part/src/model/login_model.dart';
import 'package:profile_part/src/model/review_model.dart';
import 'package:profile_part/src/widget/Text_Widget/form_text.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/form_widget.dart';


class ReviewsWidget extends GetView<ReviewsController> {
  const ReviewsWidget(this.vendor, {super.key});
    final String vendor;

    
    
  @override
  Widget build(BuildContext context) {
       Get.put(ReviewsController("Opal Nail Spa"));

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

    ))
             ,   Expanded(
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
                            )
                          )), 
                        ),
                    ),
                  ),
                ),
              ],
            );
  }
  
  reviewDialog(BuildContext context) {
    final reviewsController = Get.put(ReviewsController("Opal Nail Spa"));

  TextEditingController review = TextEditingController();

  	
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

                          inputFormat: [])),

                  SizedBox(

                    height: AppConst.smallSize.h,

                  ),

                  ButtonWidget(
                    onTap: () {
                      reviewsController.
                      addReview( Review(userEmail:"modtech7677@gmail.com", 
                      vendorName:"Opal Nail Spa", rating:reviewsController.rate, comment:reviewsController.comment.text.trim(), timestamp: DateTime.now() ));  
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


 

