import 'package:betterreads/home/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0x18F1F4F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF57636C),
          automaticallyImplyLeading: false,
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
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: Container(
              width: 251,
              height: 84,
              decoration: BoxDecoration(
                color: const Color(0x54A28888),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    '\nYou Have Checked Out Successfully!\n',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFFBFCFC),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to the main page or perform other actions.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Go Back to Main Page',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
