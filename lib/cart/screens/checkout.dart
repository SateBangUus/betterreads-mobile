import 'package:betterreads/cart/screens/success.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betterreads/cart/models/buybook.dart';
import 'package:betterreads/cart/widgets/bookinfo.dart';

class HomePageWidget extends StatefulWidget {
  final int id;
  const HomePageWidget({super.key, required this.id});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
Future<List<Product>> getProduct() async {
  
    final int id = widget.id;
    
    var url = Uri.parse(
        'https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/get-product-flutter/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Product> listBuy = [];
    for (var d in data) {
      if (d != null && d['user'] == id) {
        Product books = Product.fromJson(d);
        listBuy.add(books);
      }
    }

    return listBuy;
  }
  void refreshC() {
    setState(() {
      getProduct();
    });
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
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: FutureBuilder(
          future: getProduct(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "You have no Product.",
                      style: TextStyle(color: Color(0xFF236BF1), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Replace the following with your actual search bar widget
                        const SizedBox(height: 30.0),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var cartItem = snapshot.data![index];
                            return CheckoutCard(
                              id: cartItem.id,
                              title: cartItem.bookTitle,
                              author: cartItem.bookAuthor,
                              imageURL: cartItem.bookImg,
                              amount: cartItem.bookAmount,
                              refreshCheckout: refreshC,
                            );
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutWidget(),
                                        ),
                                      );
                                      // Navigate back to the main page or perform other actions
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue, // Change to your desired color
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                        )
                  )
                    );
            }
            }
          }  
                )
    );
  }
}