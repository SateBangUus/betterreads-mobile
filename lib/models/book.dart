// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String title;
  String author;
  String publisher;
  DateTime publishedDate;
  String description;
  String genre;
  String imageLink;

  Fields({
    required this.title,
    required this.author,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.genre,
    required this.imageLink,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        publisher: json["publisher"],
        publishedDate: (json["published_date"].toString().length == 4)
            ? DateTime(int.parse(json["published_date"].toString()), 1, 1)
            : DateTime.parse(json["published_date"].toString()),
        description: json["description"],
        genre: json["genre"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "publisher": publisher,
        "published_date":
            "${publishedDate.year.toString()}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "genre": genre,
        "image_link": imageLink,
      };
}
