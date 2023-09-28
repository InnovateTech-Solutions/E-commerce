import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/model/review_model.dart';

class ReviewsController extends GetxController {
  final String vendor;
  ReviewsController(this.vendor);

  final TextEditingController comment = TextEditingController();
  late final double rate;
  late double totalRating;
  late int reviewCount;
  late double averageRating;
  final reviewsDb = FirebaseFirestore.instance.collection('Reviews');
  List<Review> reviews = <Review>[].obs;

  @override
  void onInit() {
    super.onInit();
    getReviewsByVendor(vendor);
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

      await updateVendorRating(review.vendorName);

      print('Review added successfully');
    } catch (e) {
      print('Error adding review: $e');
    }
  }

  Future<void> updateVendorRating(String vendorName) async {
    final QuerySnapshot reviewsQuery =
        await reviewsDb.where('vendorName', isEqualTo: vendorName).get();
    //calculating rating of each vendor and updating it in vendors collection

    calculateAverageRating(reviewsQuery);
    String roundedValue = averageRating.toStringAsFixed(1);
    averageRating = double.parse(roundedValue);

    FirebaseFirestore.instance
        .collection("Vendors")
        .where('Name', isEqualTo: vendorName)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        userDoc.reference.update({
          'reviewCount': reviewCount,
          'averageRating': averageRating,
        });
      }
    });
  }

  void calculateAverageRating(QuerySnapshot reviewsQuery) {
    totalRating = 0;
    reviewCount = reviewsQuery.docs.length;
    for (QueryDocumentSnapshot reviewDoc in reviewsQuery.docs) {
      final double rating = reviewDoc['rating'] as double;
      totalRating += rating;
    }

    averageRating = reviewCount > 0 ? totalRating / reviewCount : 0;
  }

  Future<int> getReviewsCountByVendor(vendorName) async {
    final QuerySnapshot reviewsQuery =
        await reviewsDb.where('vendorName', isEqualTo: vendorName).get();
    int reviewCount = reviewsQuery.docs.length;
    return reviewCount;
  }

  //   Future<int> getAverageReviewsVendor(vendorName) async {
  //   final QuerySnapshot reviewsQuery =
  //      await FirebaseFirestore.instance
  //       .collection("Vendors").where('vendorName', isEqualTo: vendorName).get();
  //   int reviewCount = reviewsQuery.docs.length;
  //   return reviewCount;
  // }

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
