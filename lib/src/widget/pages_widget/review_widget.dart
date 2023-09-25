import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_Widget.dart/form_widget.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
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
            Column(
              children: [
                blueText("Name"),
                blueText("description"),
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
    ));
  }

  reviewDialog(BuildContext context) {
    TextEditingController Review = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Form(
            child: AlertDialog(
              title: blueText("Add review"),
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
                      // print(rating);
                    },
                  ),
                  SizedBox(
                    height: AppConst.smallSize.h,
                  ),
                  blueText("Write a Feedback"),
                  FormWidget(
                      login: Login(
                          enable: true,
                          controller: Review,
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
                    onTap: () {},
                    tilte: 'submit',
                  )
                ],
              ),
            ),
          );
        });
  }
}
