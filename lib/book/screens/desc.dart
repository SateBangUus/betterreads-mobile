import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betterreads/book/models/book.dart';
import 'package:betterreads/book/models/reviews.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Future<Book> _bookFuture;
  late Future<List<Review>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = fetchBook();
    _reviewsFuture = fetchReviews();
  }

Future<Book> fetchBook() async {
  final url = Uri.parse('http://127.0.0.1:8000/book/json/${widget.bookId}/');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var bookData = Book.fromJson(jsonDecode(response.body));

    // Print the Book object
    print('Book Data: $bookData');

    return bookData;
  } else {
    throw Exception('Failed to load book: ${response.body}');
  }
}


Future<List<Review>> fetchReviews() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/book/reviews/json/${widget.bookId}/'));
  
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);

    List<Review> reviews = [];
    for (var reviewJson in jsonResponse) {

      reviews.add(Review.fromJson(reviewJson));
    }

    return reviews;
  } else {
    throw Exception('Failed to load reviews'); 
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0x18F1F4F8),
    appBar: AppBar(
      backgroundColor: const Color(0xFF57636C), // Change to your desired color
      automaticallyImplyLeading: false,
      title: const Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'BOOK',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Color(0xFF236BF1),
              fontSize: 22,
            ),
          ),
          Text(
            'DESCRIPTION',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              color: Color(0xFFEC2F3F),
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: const [],
      centerTitle: false,
      elevation: 2,
    ),
    body: FutureBuilder<Book>(
      future: fetchBook(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(snapshot.data!.imageLink),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Author: ${snapshot.data!.author}'),
                      Text('Publisher: ${snapshot.data!.publisher}'),
                      Text('Published Date: ${snapshot.data!.publishedDate.toString()}'),
                      Text('Genre: ${snapshot.data!.genre}'),
                      const SizedBox(height: 8),
                      Text(snapshot.data!.description),
                      const SizedBox(height: 20),
                      FutureBuilder<List<Review>>(
                        future: _reviewsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            List<Widget> reviewListTiles = [];
                            for (Review review in snapshot.data!) {
                              
                              reviewListTiles.add(
                                ListTile(
                                  title: Text(review.user),
                                  subtitle: Text(review.description),
                                  trailing: Text('Rating: ${review.rating}'),
                                )
                              );
                            }

                            return Column(
                              children: reviewListTiles,
                            );
                          } else {
                            return const Text('No reviews available');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    ),
  );
}
}