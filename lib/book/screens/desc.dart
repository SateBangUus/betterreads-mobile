import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betterreads/book/models/book.dart';
import 'package:betterreads/book/models/reviews.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final url = Uri.parse('http://betterreads-k3-tk.pbp.cs.ui.ac.id/book/json/${widget.bookId}/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var bookData = Book.fromJson(jsonDecode(jsonDecode(response.body))[0]);
      return bookData;
    } else {
      throw Exception('Failed to load book: ${response.body}');
    }
  }

  Future<List<Review>> fetchReviews() async {
    final response = await http.get(Uri.parse('http://betterreads-k3-tk.pbp.cs.ui.ac.id/book/reviews/json/${widget.bookId}/'));
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
    final _reviewController = TextEditingController();
    final request = context.watch<CookieRequest>();
    double _rating = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Better',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF236BF1),
                  fontSize: 22,
                ),
              ),
              Text(
                'Reads',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFFEC2F3F),
                  fontSize: 22,
                ),
              ),
            ],
          ),
        centerTitle: false,
      ),
      body: FutureBuilder<Book>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Image
                  Container(
                    height: 200, // Adjust the height as needed
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.fields.imageLink), // Replace with the actual image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title: ${snapshot.data!.fields.title}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Author: ${snapshot.data!.fields.author}'),
                        Text('Publisher: ${snapshot.data!.fields.publisher}'),
                        Text('Published Date: ${snapshot.data!.fields.publishedDate.toString()}'),
                        Text('Genre: ${snapshot.data!.fields.genre}'),
                        Text('Description: ${snapshot.data!.fields.description}', textAlign: TextAlign.justify),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                        TextField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                            hintText: 'Write a review',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Implement the logic to submit the review
                            var response = await request.postJson(
                              "http://betterreads-k3-tk.pbp.cs.ui.ac.id/book/reviews/json/${widget.bookId}/",
                              jsonEncode({
                                'user': request.getJsonData()['username'], // Replace with the actual user identifier
                                'rating': _rating,
                                'description': _reviewController.text,
                              }),
                            );
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review added successfully')));
                              // Clear the fields
                              _reviewController.clear();
                              setState(() => _rating = 0.0);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add review')));
                            }
                          },
                          child: Text('Submit Review'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}