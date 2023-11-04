// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/review_model.dart';

class ReviewsController extends GetxController {
  final String vendor;
  ReviewsController(this.vendor);

  final TextEditingController comment = TextEditingController();
  late double rate = 5.0;
  late double totalRating;
  late int reviewCount;
  late RxDouble averageRating = 0.0.obs;
  final reviewsDb = FirebaseFirestore.instance.collection('Reviews');
  List<Review> reviews = <Review>[].obs;

  List<Review> get nonEmptyComments {
    if (reviews.where((review) => review.comment.isNotEmpty).toList().isEmpty) {
      return reviews.where((review) => review.comment.isEmpty).toList();
    } else {
      return reviews.where((reviews) => reviews.comment.isNotEmpty).toList();
    }
  }

  List<Review> get emptyComments {
    return reviews.where((review) => review.comment.isEmpty).toList();
  }

  int getListValue(List myList) {
    myList.shuffle();
    if (myList == null) {
      return 0;
    } else if (myList.length > 2) {
      return 2;
    } else if (myList.length > 1) {
      return 1;
    } else if (myList.length == 0) {
      return 0;
    } else {
      return 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getReviewsByVendor(vendor);
    calculateAverageRating(vendor);
  }

  @override
  void onReady() {
    super.onReady();
  }

//This method adds reviews to the database taking review model
  Future<void> addReview(Review review) async {
    try {
      await reviewsDb.add(review.toMap());
      reviews.add(review);
      calculateAverageRating(review.vendorName);

      print('Review added successfully');
    } catch (e) {
      print('Error adding review: $e');
    }
  }

// calculates the average rating for each vendor by taking the vendor name
  void calculateAverageRating(String vendorName) async {
    final QuerySnapshot reviewsQuery =
        await reviewsDb.where('vendorName', isEqualTo: vendorName).get();
    totalRating = 0;
    reviewCount = reviewsQuery.docs.length;
    for (QueryDocumentSnapshot reviewDoc in reviewsQuery.docs) {
      final double rating = reviewDoc['rating'] as double;
      totalRating += rating;
    }

    averageRating = reviewCount > 0 ? (totalRating / reviewCount).obs : 0.0.obs;
    String roundedValue = averageRating.toStringAsFixed(1);
    averageRating = double.parse(roundedValue).obs;
  }

// fetches the list of reviews for each vendor by taking the vendor name
  Future<List<Review>> getReviewsByVendor(String vendorName) async {
    try {
      final QuerySnapshot reviewsQuery =
          await reviewsDb.where('vendorName', isEqualTo: vendorName).get();

      for (QueryDocumentSnapshot reviewDoc in reviewsQuery.docs) {
        // Convert Firestore document into a Review object
        final Review review =
            Review.fromMap(reviewDoc.data() as Map<String, dynamic>);
        reviews.add(review);
      }

      return reviews;
    } catch (e) {
      print('Error fetching reviews by vendor: $e');
      return []; // Return an empty list in case of an error
    }
  }
}
