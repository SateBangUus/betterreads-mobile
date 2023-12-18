import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betterreads/cart/buybook.dart';
import 'package:betterreads/cart/tools/toolsbuy.dart';
import 'package:betterreads/cart/widgets/bookinfo.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Product> finalbook = [];
  late int countControllerValue1;
  late int countControllerValue2;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    countControllerValue1 = 1;
    countControllerValue2 = 1;
  }

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
        backgroundColor: Color(0x18F1F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFF57636C), // Change to your desired color
          automaticallyImplyLeading: false,
          title: Row(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: getCart(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Product list = snapshot.data![index];
                          return bookInfoCard(
                            bookInfo: list,
                            index: index,
                            lastIndex: snapshot.data!.length,
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Button pressed ...');
                      // Navigate back to the main page or perform other actions.
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Change to your desired color
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Product>> getCart() async {
    var jsonMap = await FetcherCart().getCart();
    finalbook = jsonMap.map((item) => Product.fromJson(item)).toList();
    return finalbook;
  }
}
