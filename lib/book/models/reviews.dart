import 'dart:convert';
import 'package:betterreads/book/models/book.dart';
import 'package:betterreads/user/models/user.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  int reviewId;
  User user; // Assuming you want to include basic user info
  String description;
  double rating;
  bool isCurator;
  Book book; // Assuming you want to include basic book info

  Review({
    required this.reviewId,
    required this.user,
    required this.description,
    required this.rating,
    required this.isCurator,
    required this.book,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["id"],
        user: User.fromJson(json["user"]),
        description: json["description"],
        rating: json["rating"].toDouble(),
        isCurator: json["is_curator"],
        book: Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": reviewId,
        "user": user.toJson(),
        "description": description,
        "rating": rating,
        "is_curator": isCurator,
        "book": book.toJson(),
      };
}
