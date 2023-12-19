import 'package:betterreads/cart/screens/success.dart';
import 'package:betterreads/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:betterreads/book/models/book.dart';
import 'package:betterreads/cart/widgets/bookinfo.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  Future<List<Book>> getProduct() async {

    var url = Uri.parse(
        'https://betterreads-k3-tk.pbp.cs.ui.ac.id/buy/get-product-flutter/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> listBuy = [];
    for (var d in data) {
      if (d != null) {
        Book books = Book.fromJson(d);
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
        appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 64, 64, 64),// Change to your desired color
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
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: getProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
             } else {
                if (!snapshot.hasData) {
                  return const Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8, left: 6, right: 6),
                child: Text(
                  'You have no items in the cart!',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
            ]
                  ));
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
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
                                          builder: (context) =>
                                              CheckoutWidget(),
                                        ),
                                      );
                                      // Navigate back to the main page or perform other actions
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .blue, // Change to your desired color
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
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
                      ])));
                }
              }
            }
            ));
  }
}
