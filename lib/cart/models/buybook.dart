// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String title;
  String author;
  String imageLink;
  int amount;
  int id;

  Product({
    required this.title,
    required this.author,
    required this.imageLink,
    required this.amount,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"]?? "",
        author: json["author"]?? "",
        imageLink: json["image_link"]?? "",
        amount: json["amount"]?? 0,
        id: json["id"]?? 0,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "image_link": imageLink,
        "id": id,
        "amount":amount
      };
}
