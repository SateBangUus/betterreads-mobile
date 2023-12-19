import 'dart:convert';
import 'package:betterreads/book/models/book.dart';
import 'package:betterreads/user/models/user.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

List<Review> reviewsFromJson(String str) {
  Iterable jsonList = json.decode(str);
  return List<Review>.from(jsonList.map((jsonItem) => Review.fromJson(jsonItem)));
}

class Review {
  int reviewId;
  String user; // Assuming you want to include basic user info
  String description;
  double rating;
  bool isCurator;

  Review({
    required this.reviewId,
    required this.user,
    required this.description,
    required this.rating,
    required this.isCurator,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["id"],
        user: json["user"],
        description: json["description"],
        rating: json["rating"].toDouble(),
        isCurator: json.containsKey("is_curator") ? json["is_curator"] : false,
      );

  Map<String, dynamic> toJson() => {
        "id": reviewId,
        "user": user,
        "description": description,
        "rating": rating,
        "is_curator": isCurator,
      };
}
