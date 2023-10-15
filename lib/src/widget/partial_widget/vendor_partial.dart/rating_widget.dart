import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:profile_part/src/widget/Text_Widget/vendor_text.dart';

ratingBarIndicator(String rate, String totalReviews) {
  return Row(
    children: [
      subvendorText(rate),
      RatingBarIndicator(
          rating: double.parse(rate),
          itemCount: 5,
          itemSize: 20.0,
          itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.yellow,
              )),
      subvendorText('($totalReviews)'),
    ],
  );
}
