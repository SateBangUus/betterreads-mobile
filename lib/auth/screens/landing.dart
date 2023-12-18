import 'package:betterreads/auth/screens/login.dart';
import 'package:betterreads/auth/screens/register.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
                          fontSize: MediaQuery.sizeOf(context).width / 7,
                          shadows: [
                            Shadow(
                                offset: Offset(8, 8),
                                blurRadius: 10,
                                color: Color.fromARGB(85, 0, 0, 0))
                          ],
                        ),
                        children: [
                          TextSpan(
                              text: "Reads",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width / 7))
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
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()))
                              },
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              18)))),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()))
                              },
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Register",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              18))),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)),
                    ],
                  )
                ],
              ),
            )));
  }
}
