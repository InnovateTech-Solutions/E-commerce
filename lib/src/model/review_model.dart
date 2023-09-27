import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String userEmail;
  final String vendorName;
  final double rating;
  final String comment;
  final DateTime timestamp;

  Review({
    required this.userEmail,
    required this.vendorName,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      userEmail: data['userEmail'],
      vendorName: data['vendorName'],
      rating: data['rating'].toDouble(),
      comment: data['comment'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'vendorName': vendorName,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp,
    };
  }
 }
