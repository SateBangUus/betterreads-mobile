import 'package:betterreads/auth/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LandingApp());
}

class LandingApp extends StatelessWidget {
  const LandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Better",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 64,
                            shadows: [
                              Shadow(offset: Offset(8, 8), blurRadius: 10, color: Color.fromARGB(85, 0, 0, 0))
                            ],),
                        children: [
                          TextSpan(
                              text: "Reads",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 64))
                        ]),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage())
                            )
                          },
                          child:
                              Text("Login", style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 45))),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () => {},
                          child:
                              Text("Register", style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 45), backgroundColor: Colors.red))
                    ],
                  )
                ],
              ),
            )));
  }
}
