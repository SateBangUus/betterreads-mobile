import 'dart:convert';

import 'package:betterreads/models/user_review.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String username;
  String profilePicture;
  String email;
  String firstName;
  String lastName;
  bool isCurator;
  String joinDate;
  List<UserReview> topReviews;
  num totalReviewsl;
  num averageRating;
  List<dynamic> favGenres;

  User({
    required this.username,
    required this.profilePicture,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isCurator,
    required this.joinDate,
    required this.topReviews,
    required this.totalReviewsl,
    required this.averageRating,
    required this.favGenres,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        profilePicture: json["profile_picture"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isCurator: json["is_curator"],
        joinDate: json["join_date"],
        topReviews: List<UserReview>.from(
            json["top_reviews"].map((x) => UserReview.fromJson(x))),
        totalReviewsl: json["total_reviewsl"],
        averageRating: json["average_rating"],
        favGenres: List<dynamic>.from(json["fav_genres"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "profile_picture": profilePicture,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "is_curator": isCurator,
        "join_date": joinDate,
        "top_reviews": List<UserReview>.from(topReviews.map((x) => x)),
        "total_reviewsl": totalReviewsl,
        "average_rating": averageRating,
        "fav_genres": List<dynamic>.from(favGenres.map((x) => x)),
      };
}
