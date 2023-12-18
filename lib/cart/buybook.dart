// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int user;
    int id;
    String title;
    String author;
    String publisher;
    DateTime publishedDate;
    String description;
    String genre;
    String imageLink;

    Product({
        required this.user,
        required this.id,
        required this.title,
        required this.author,
        required this.publisher,
        required this.publishedDate,
        required this.description,
        required this.genre,
        required this.imageLink,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        user: json["user"],
        id: json["id"],
        title: json["title"],
        author: json["author"],
        publisher: json["publisher"],
        publishedDate: DateTime.parse(json["published_date"]),
        description: json["description"],
        genre: json["genre"],
        imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "id": id,
        "title": title,
        "author": author,
        "publisher": publisher,
        "published_date": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "genre": genre,
        "image_link": imageLink,
    };
}
