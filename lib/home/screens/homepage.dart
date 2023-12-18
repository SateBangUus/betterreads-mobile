import 'package:flutter/material.dart';
import 'package:betterreads/home/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  shadows: [
                    Shadow(offset: Offset(8, 8), blurRadius: 10, color: Color.fromARGB(85, 0, 0, 0))
                  ],),
              children: [
                TextSpan(
                    text: "Reads",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30))
              ]),
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
                          shadows: [
                            Shadow(offset: Offset(8, 8), blurRadius: 10, color: Color.fromARGB(85, 0, 0, 0))
                          ],),
                      children: [
                        TextSpan(
                            text: "Reads",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 35)
                          )
                      ]),
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
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}