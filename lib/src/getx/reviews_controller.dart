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
  void calculateAverageRating(String vendorName) async  {
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



    //currently not used, left for future work
  // Future<void> updateVendorRating(String vendorName) async {
 
  //   //calculating rating of each vendor and updating it in vendors collection

  //   calculateAverageRating(vendorName);
  

  //   FirebaseFirestore.instance
  //       .collection("Vendors")
  //       .where('Name', isEqualTo: vendorName)
  //       .get()
  //       .then((querySnapshot) {
  //     if (querySnapshot.docs.isNotEmpty) {
  //       var userDoc = querySnapshot.docs.first;
  //       userDoc.reference.update({
  //         'reviewCount': reviewCount,
  //         'averageRating': averageRating,
  //       });
  //     }
  //   });
  // }

//currently not used, left for future work
// void getAverageRatingByVendor(String vendorName) async {
//   try {
//     final QuerySnapshot vendorsQuery = await FirebaseFirestore.instance
//         .collection("Vendors")
//         .where('Name', isEqualTo: vendorName)
//         .get();

//     if (vendorsQuery.docs.isNotEmpty) {
//       final vendorDoc = vendorsQuery.docs.first;
//       final avgRating = vendorDoc['averageRating'] as double;
//       averageRating = avgRating.obs;
//     } else {
//       averageRating.value = 0.0; // If there are no matching vendors, set a default rating of 0.0
//     }
//   } catch (e) {
//     print('Error getting average rating by vendor: $e');
//     averageRating.value = 0.0; // Set a default rating of 0.0 in case of an error
//   }
// }
}
