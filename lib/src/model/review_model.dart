class Review {
  String feedback;
  int review;

  Review({required this.feedback, required this.review});

  factory Review.fromJson(Map<String, dynamic> json) =>
      Review(feedback: json[""], review: json[""]);

  Map<String, dynamic> toJson() => {"": ""};
}
