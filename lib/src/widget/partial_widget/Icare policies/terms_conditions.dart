import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile_part/src/widget/Text_Widget/policy_text.dart';

class TermsConditions {
  static Container title() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      alignment: Alignment.centerLeft,
      child: policyTitle('additional terms and conditions'),
    );
  }

  static Column content() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: policyContent(
                'Deposits are non-refundable, you can reschedule your appointment and your deposit will be transferred over to your future booking. If you are unable to reschedule, please contact us at least 48 hours before your appointment.')),
        SizedBox(height: 120.h)
      ],
    );
  }
}
