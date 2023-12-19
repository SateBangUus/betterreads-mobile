import 'package:betterreads/book/screens/desc.dart';
import 'package:betterreads/home/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
          title: 'BetterReads',
          theme: ThemeData.dark(),
          home: const BookDetailPage(bookId: 1), // Replace 1 with an actual book ID
      ),
    );
  }
}
