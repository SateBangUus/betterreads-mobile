// To parse this JSON data, do
//
//     final userReview = userReviewFromJson(jsonString);

import 'dart:convert';
import 'package:betterreads/models/book.dart';

UserReview userReviewFromJson(String str) =>
    UserReview.fromJson(json.decode(str));

String userReviewToJson(UserReview data) => json.encode(data.toJson());

class UserReview {
  double rating;
  Book book;

  UserReview({
    required this.rating,
    required this.book,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      rating: json["rating"],
      book: Book.fromJson(jsonDecode(json["book"])[0]),
    );
  }

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "book": book,
      };
}
