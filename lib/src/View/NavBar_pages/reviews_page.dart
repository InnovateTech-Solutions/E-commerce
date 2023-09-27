import 'package:flutter/material.dart';
import 'package:profile_part/src/View/reviews_test.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/first_appbar.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/categories_widget.dart';
import 'package:profile_part/src/widget/pages_widget/Products/add_review.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        appBar: secondAppBar(),
        body: const ReviewsWidget("Opal Nail Spa"),
      ),
    );
  }
}
