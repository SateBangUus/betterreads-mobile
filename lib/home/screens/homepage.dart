import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:betterreads/home/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:betterreads/book/models/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: "Better",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              shadows: [Shadow(offset: Offset(8, 8), blurRadius: 10, color: Color.fromARGB(85, 0, 0, 0))],
            ),
            children: [
              TextSpan(
                text: "Reads",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 64, 64),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8, left: 6, right: 6),
                child: RichText(
                  text: const TextSpan(
                    text: "Better",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      shadows: [Shadow(offset: Offset(8, 8), blurRadius: 10, color: Color.fromARGB(85, 0, 0, 0))],
                    ),
                    children: [
                      TextSpan(
                        text: "Reads",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
                child: Text(
                  'Hello, Great to see you again!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Books',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchBooks(request, _searchController.text);
                      },
                    ),
                  ),
                ),
              ),
              _books.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_books[index].title),
                              subtitle: Text(_books[index].author),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _searchBooks(request, query) async {
    final response = await request.get(
      request.get('http://127.0.0.1:8000/search-book-flutter/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        _books.clear();
        for (var bookData in data) {
          final book = Book(
            title:        bookData['fields']['title'],
            author:       bookData['fields']['author'],
            publisher:    bookData['fields']['publisher'], 
            description:  bookData['fields']['description'], 
            genre:        bookData['fields']['genre'], 
            imageLink:    bookData['fields']['image_link'], 
            id:           bookData['pk'] 
          );
          _books.add(book);
        }
      });
    } else {
      throw Exception('Failed to load books');
    }
  }
}